import 'package:chatapp/bloc/loginBloc/login_bloc.dart';
import 'package:chatapp/bloc/loginBloc/login_event.dart';
import 'package:chatapp/bloc/loginBloc/login_state.dart';
import 'package:chatapp/helper/helper_functions.dart';
import 'package:chatapp/services/database_methods.dart';
import 'package:chatapp/views/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'conversations.dart';


class SingInParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> LoginBloc(),
      child: SignIn(),
    );  }
}

class SignIn extends StatelessWidget {


  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {

    loginBloc=BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('chat App' , style: TextStyle(color: Colors.black54),),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocListener<LoginBloc,LoginState>(
                        listener:(context , state) {
                          if (state is LoginSuccessState) {
                            dataBaseMethods.getUserByEmail(emailController.text).then((val){
                              HelperFunctions.saveUserLoggedInsharedPreference(true);
                              HelperFunctions.saveUserEmailsharedPreference(emailController.text);
                              HelperFunctions.saveUserNamesharedPreference('hello');
                              HelperFunctions.saveUserIdsharedPreference(FirebaseAuth.instance.currentUser.uid);
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return Conversations();
                                  }));
                              
                            });
                      
                          }
                        }
    ,
                  child: BlocBuilder<LoginBloc,LoginState>(
                    builder:(context , state){
                      if(state is LoginSuccessState)
                       return Container(color: Colors.yellow,);
                      else {
                        return Container(color: Colors.red,);
                      }
                    },
                  ),),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                  ),
                  SizedBox(height: 16,),
                  FlatButton(
                    child:Text('Sign In'),
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      loginBloc.add(LoginButtonPressedEvent(email:
                      emailController.text,
                          password:passwordController.text));

                    },),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ? ") ,
                      GestureDetector(
                        child: Text("Register",
                          style: TextStyle(
                         decoration: TextDecoration.underline
                        ),),
                        onTap: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){return SignUpParent();} ));
                        },
                      )
                    ],
                  ),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}
