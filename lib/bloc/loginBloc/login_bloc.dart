import 'package:chatapp/bloc/loginBloc/login_event.dart';
import 'package:chatapp/bloc/loginBloc/login_state.dart';
import 'package:chatapp/repositories/user_repository.dart';
import 'package:chatapp/views/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  UserRepository userRepository;
  LoginBloc()
  {
    userRepository = new UserRepository();
  }
  @override
  LoginState get initialState => LoginInit();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginButtonPressedEvent)
      {
        try {
          yield LoginLoadingState();
          var user = await userRepository.signInUser(
              event.email, event.password);
          yield LoginSuccessState(user: user);
        }
        catch (e){
          yield LoginFaliureState(msg: e.toString());
        }
      }
  }

}