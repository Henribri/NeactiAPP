
import 'package:equatable/equatable.dart';

abstract class InviteEvent{}

/// Event to get Category
class InviteFetched extends InviteEvent{}

/// Event to post an Activity
class InvitePost extends InviteEvent{

  Map body;
  InvitePost(this.body);

}