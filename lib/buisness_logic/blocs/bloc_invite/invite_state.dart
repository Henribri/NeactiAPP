import 'package:equatable/equatable.dart';
import 'package:neacti/buisness_logic/models/category.dart';
import 'package:neacti/buisness_logic/models/event.dart';

abstract class InviteState{
  const InviteState();

  List<Category> get getCategories => null;

}

class InviteInitial extends InviteState{}

class InviteGetFailure extends InviteState{}

class InviteConnectionFailure extends InviteState{}


/// State return after a fail request
class InvitePostFailure extends InviteState{

  List<Category> categories;

  InvitePostFailure({
    this.categories
  });

  InvitePostFailure copyWith(List<Category> categories){
    return InvitePostFailure(
        categories: categories??this.categories
    );
  }

  @override
  List<Category> get getCategories => categories;
}


/// State return after a Get request
class InviteGetSuccess extends InviteState{

  List<Category> categories;

  InviteGetSuccess({
    this.categories
  });

  InviteGetSuccess copyWith(List<Category> categories){
    return InviteGetSuccess(
        categories: categories??this.categories
    );
  }
  @override
  List<Category> get getCategories => categories;

}


/// State return after a post request
class InvitePostSuccess extends InviteState{

  List<Category> categories;

  InvitePostSuccess({
    this.categories
  });

  InvitePostSuccess copyWith(List<Category> categories){
    return InvitePostSuccess(
        categories: categories??this.categories
    );
  }
  @override
  List<Category> get getCategories => categories;

}

