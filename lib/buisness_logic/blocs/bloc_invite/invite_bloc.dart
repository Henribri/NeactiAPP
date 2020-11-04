import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:neacti/buisness_logic/models/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:neacti/buisness_logic/models/apiUrl.dart';
import 'package:neacti/buisness_logic/blocs/bloc_invite/invite_event.dart';
import 'package:neacti/buisness_logic/blocs/bloc_invite/invite_state.dart';
import 'package:http/http.dart' as http;

class InviteBloc extends Bloc<InviteEvent, InviteState>{


  InviteBloc() : super(InviteInitial());

  @override
  Stream<InviteState> mapEventToState(InviteEvent event) async*{

    /// Init the state
    final currentState = state;

    /// Handle Get Events
    if (event is InviteFetched){
      try {
      if(! await _isConnected()){
        yield InviteConnectionFailure();
      }

        else {
          final categories = await _getCategoryList();
          yield InviteGetSuccess(categories: categories);
        }
      }
      catch(_){
        yield InviteGetFailure();
      }
    }


    /// Handle Post Events
    if (event is InvitePost){
       bool error = await _postEvent(body:event.body);

       if (error){
           yield InvitePostFailure(categories: currentState.getCategories);
       }
       else{
             yield InvitePostSuccess(categories: currentState.getCategories);
       }
    }

  }



  /// Get category
  Future<List<Category>> _getCategoryList() async {
    String apiUrl = ApiUrl.apiUrl;
    Response response = await get('http://$apiUrl/category.json');
    List<dynamic> data = jsonDecode(response.body);

    return data.map((i) => Category.fromJson(i)).toList();
  }


  /// Post activity
  Future<bool> _postEvent({Map body}) async {
    String apiUrl = ApiUrl.apiUrl;
    String url = 'http://$apiUrl/events/';
    Map<String, String> headers = {"Content-type": "application/json"};
    try{
    Response response =
    await post(url, headers: headers, body: json.encode(body));

    if (response.statusCode < 200 ||
        response.statusCode > 400 ||
        json == null) {
      /// Return error
      return true;
    } else {

      /// Return no error
      return false;

      //flush.dismiss(true);
    }}catch(_){
      return true;
    }
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




}