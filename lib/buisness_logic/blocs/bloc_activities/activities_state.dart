import 'package:neacti/buisness_logic/models/event.dart';

/// Different State of activities
abstract class ActivitiesState {

  const ActivitiesState();

  List<Activity> get getActivities => null;
}

class ActivitiesInitial extends ActivitiesState{}

class ActivitiesConnectionFailure extends ActivitiesState{}

class ActivitiesGetSuccess extends ActivitiesState{

  List<Activity> activities;

  ActivitiesGetSuccess({this.activities});

  @override
  // TODO: implement getActivities
  List<Activity> get getActivities => activities;

}


class ActivitiesGetFailure extends ActivitiesState{}


class ActivitiesPatchSuccess extends ActivitiesState{}


class ActivitiesPatchFailure extends ActivitiesState{}
