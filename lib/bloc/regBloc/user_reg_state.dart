
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRegState extends Equatable {

}
class UserRegInit extends UserRegState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class UserLoadingState extends UserRegState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class UserRegSuccessful extends UserRegState{
  User user ;
  UserRegSuccessful(this.user);

  List<Object> get props => throw UnimplementedError();
}
class UserRegFailed extends UserRegState{

  String message ;
  UserRegFailed(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}