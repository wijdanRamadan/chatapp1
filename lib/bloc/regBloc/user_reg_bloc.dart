import 'package:bloc/bloc.dart';
import 'package:chatapp/bloc/regBloc/user_reg_event.dart';
import 'package:chatapp/bloc/regBloc/user_reg_state.dart';
import 'package:chatapp/repositories/user_repository.dart';


class UserRegBloc extends Bloc<UserRegEvent,UserRegState> {

  UserRepository userRepository;

  UserRegBloc() {
    userRepository=UserRepository();
  }

  @override
  // TODO: implement initialState
  UserRegState get initialState => UserRegInit();

  @override
  Stream<UserRegState> mapEventToState(UserRegEvent event) async* {
    if(event is SignUpButtonPressedEvent){
      try {
        yield UserLoadingState();
        var user = await userRepository.createUser(event.email, event.password);
        yield UserRegSuccessful(user);
      }
      catch(e){
        yield UserRegFailed(e.toString());
      }
    }
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
  
}