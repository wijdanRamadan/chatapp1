import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginState extends Equatable {}
class LoginInit extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class LoginLoadingState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginSuccessState extends LoginState {

  User user;
  LoginSuccessState({@required this.user});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginFaliureState extends LoginState {

  String msg;

  LoginFaliureState({@required this.msg});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}