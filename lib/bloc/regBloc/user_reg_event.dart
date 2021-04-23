import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserRegEvent extends Equatable{

}
class SignUpButtonPressedEvent extends UserRegEvent{

  String email , password;
  SignUpButtonPressedEvent({@required this.email ,@required this.password});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}