import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:neacti/models/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:neacti/models/apiUrl.dart';
import 'package:neacti/screens/invite/bloc/event.dart';
import 'package:neacti/screens/invite/bloc/state.dart';
import 'package:http/http.dart' as http;

class InviteBloc extends Bloc<InviteEvent, InviteState>{


  InviteBloc() : super(InviteInitial());

  @override
  Stream<InviteState> mapEventToState(InviteEvent event) async*{

    final currentState = state;

    if (event is InviteFetched){
      try{
        if(currentState is InviteInitial) {
          final categories = await _getCategoryList();
          yield InviteSuccess(categories: categories);
        }
        if(currentState is InviteSuccess){
          final categories = await _getCategoryList();
          yield currentState.copyWith(categories);
        }
        }


      catch(_){
        yield InviteFailure();
      }
    }

    if (event is InvitePost){

    }

  }


  /// Get category
  Future<List<Category>> _getCategoryList() async {
    String apiUrl = ApiUrl.apiUrl;
    Response response = await get('http://$apiUrl/category.json');
    List<dynamic> data = jsonDecode(response.body);

    return data.map((i) => Category.fromJson(i)).toList();
  }


}