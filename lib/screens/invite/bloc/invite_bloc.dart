import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:neacti/models/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:neacti/models/apiUrl.dart';
import 'package:neacti/screens/invite/bloc/invite_event.dart';
import 'package:neacti/screens/invite/bloc/invite_state.dart';
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
        if (currentState is InviteInitial) {
          final categories = await _getCategoryList();
          yield InviteGetSuccess(categories: categories);
        }
        if (currentState is InviteGetSuccess) {
          final categories = await _getCategoryList();
          yield currentState.copyWith(categories);
        }
      }
      catch(_){
        yield InviteGetFailure();
      }
    }


    /// Handle Post Events
    if (event is InvitePost){
       bool error = await _postEvent(body:event.body);
       print(currentState);

       if (error){
         if (currentState is InvitePostFailure) {
           yield currentState.copyWith(currentState.getCategories);
         }
         else {
           yield InvitePostFailure(categories: currentState.getCategories);
         }
       }
       else{
           if (currentState is InvitePostSuccess) {
             yield currentState.copyWith(currentState.getCategories);
           }
           else {
             yield InvitePostSuccess(categories: currentState.getCategories);
           }
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

}