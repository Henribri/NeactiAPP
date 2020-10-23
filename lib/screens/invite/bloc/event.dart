
import 'package:equatable/equatable.dart';

abstract class InviteEvent extends Equatable{

  @override
  List<Object> get props => [];

}

class InviteFetched extends InviteEvent{}

class InvitePost extends InviteEvent{



}