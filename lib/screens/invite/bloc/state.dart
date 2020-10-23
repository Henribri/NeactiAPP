
import 'package:equatable/equatable.dart';
import 'package:neacti/models/category.dart';
import 'package:neacti/models/event.dart';

abstract class InviteState extends Equatable{
  const InviteState();

  @override
  List<Category> get props => [];

}



class InviteInitial extends InviteState{}

class InviteFailure extends InviteState{}

class InviteSuccess extends InviteState{

  List<Category> categories;

  InviteSuccess({
    this.categories
  });

  InviteSuccess copyWith(List<Category> categories){
    return InviteSuccess(
        categories: categories??this.categories
    );
  }
  @override
  List<Category> get props => categories;

}

