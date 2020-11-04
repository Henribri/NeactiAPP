import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:neacti/buisness_logic/blocs/bloc_activities/activities_event.dart';
import 'package:neacti/buisness_logic/blocs/bloc_activities/activities_state.dart';
import 'package:neacti/buisness_logic/models/apiUrl.dart';
import 'package:neacti/buisness_logic/models/event.dart';
import 'package:neacti/buisness_logic/models/user.dart';

class ActivitiesBloc extends Bloc<ActivityEvent,ActivitiesState>{
  ActivitiesBloc() : super(ActivitiesInitial());



  @override
  Stream<ActivitiesState> mapEventToState(ActivityEvent event) async* {

    /// Init the state
    final currentState = state;

    /// Handle get event
    if (event is ActivityEventGet) {
      try {
        if (!await _isConnected()) {
          yield ActivitiesConnectionFailure();
        }
        else if (event.joinPage) {
          List<Activity> activities = await _getActivitiesToJoin(event.uid);
          yield ActivitiesGetSuccess(activities: activities);
        }
        else if (!event.joinPage) {
          List<Activity> activities = await _getSavedActivities(event.uid);
          yield ActivitiesGetSuccess(activities: activities);
        }
      } catch (_) {
        yield ActivitiesGetFailure();
      }
    }

    /// Handle put request
    if (event is ActivityEventPatch) {
      bool error = true;

      /// Check if it's to add or remove user from activity
      if (event.joinPage) {
        Map body = _addUserToActivity(event.uid, event.newActPeople);
        error = await _putJoinEvent(event.eventId, body);
      } else {
        Map body = _removeUserFromActivity(event.uid, event.newActPeople);
        error = await _putJoinEvent(event.eventId, body);

      }

      /// Check if there is an error
      if (error) {
        yield ActivitiesPatchFailure();
      } else {
        yield ActivitiesPatchSuccess();
      }
    }
  }

  Map _addUserToActivity(String uid, List<String> newActPeople){
    /// Variable to contain the list of User registered for the event
    Map<String, List<String>> registeredPeople = new Map<String, List<String>>();

    /// Add the user from the list of registered
    newActPeople
        .add(uid);

    /// Map it for the request
    registeredPeople["act_people"] =
        newActPeople;

    return registeredPeople;
  }


    Map _removeUserFromActivity(String uid, List<String> newActPeople){
      /// Variable to contain the list of User registered for the event
      Map<String, List<String>> registeredPeople = new Map<String, List<String>>();

      /// Remove the user from the list of registered
      newActPeople
          .removeWhere((item) =>
      item == uid);

      /// Map it for the request
      registeredPeople["act_people"] =
          newActPeople;

      return registeredPeople;
    }


  /// Return list of actual event
  Future<List<Activity>> _getActivitiesToJoin(String userId) async {


    String apiUrl = ApiUrl.apiUrl;
    Response response = await get(
        'http://$apiUrl/events/user_not_registered/$userId.json');
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    return data.map((i) => Activity.fromJson(i)).toList();
  }


  /// Return list of actual event
  Future<List<Activity>> _getSavedActivities(String userId) async {

    String apiUrl = ApiUrl.apiUrl;
    Response response =   await get('http://$apiUrl/events/user_registered/$userId.json');
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    return data.map((i) => Activity.fromJson(i)).toList();
  }



  Future<bool> _isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }else{
      return false;
    }
  }

  /// Put method to add people
  Future<bool> _putJoinEvent(String eventId, Map body) async {
    String apiUrl = ApiUrl.apiUrl;
    String url = 'http://$apiUrl/events/$eventId/';

    Map<String, String> headers = {"Content-type": "application/json"};
    try {
      Response response =
      await patch(url, headers: headers, body: json.encode(body));

      if (response.statusCode < 200 ||
          response.statusCode > 400 ||
          json == null) {
        return true;
      } else {
        return false;
      }
    }catch(_){
      return true;
    }
  }


}