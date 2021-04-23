import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable{

}
class LoginButtonPressedEvent extends LoginEvent {

  String email  , password ;
  LoginButtonPressedEvent({@required this.email , @required this.password});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}