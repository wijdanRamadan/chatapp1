
import 'package:chatapp/bloc/authBloc/auth_bloc.dart';
import 'package:chatapp/bloc/authBloc/auth_event.dart';
import 'package:chatapp/bloc/authBloc/auth_state.dart';
import 'package:chatapp/views/chat.dart';
import 'package:chatapp/views/conversations.dart';
import 'package:chatapp/views/sign_in.dart';
import 'package:chatapp/views/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
      create: (context) => AuthBloc()..add(AppStartedEvent()),
        child: ChatApp(),
      )
    );
  }
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc , AuthState> (
      builder: (context , state) {
        if (state is AuthenticatedState)
          {
               return SingInParent();
          }
        else if (state is UnAuthenticatedState)
          {
              return SingInParent();
          }
        else {

          return SingInParent();
        }

      },
    );
  }
}


