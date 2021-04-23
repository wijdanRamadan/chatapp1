
import 'package:bloc/bloc.dart';
import 'package:chatapp/repositories/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent,AuthState>
{
  UserRepository userRepository ;

  AuthBloc () {userRepository = UserRepository();}
  @override
  AuthState get initialState => AuthInitState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if(event is AppStartedEvent) {
      try {
        var isSignedIn = await userRepository.isSignedIn();
        if (isSignedIn) {
          var user = userRepository.getCurrentUser();
          yield AuthenticatedState(user: user);
        }
      }
      catch(e){
        yield UnAuthenticatedState();
      }
    }
  }
  
}