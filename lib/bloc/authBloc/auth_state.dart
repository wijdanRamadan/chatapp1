import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthState extends Equatable {}
class AuthInitState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class AuthenticatedState extends AuthState {

  User user ;
  AuthenticatedState({@required user});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UnAuthenticatedState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}