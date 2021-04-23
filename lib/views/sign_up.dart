import 'package:chatapp/bloc/regBloc/user_reg_bloc.dart';
import 'package:chatapp/bloc/regBloc/user_reg_event.dart';
import 'package:chatapp/bloc/regBloc/user_reg_state.dart';
import 'package:chatapp/helper/helper_functions.dart';
import 'package:chatapp/services/database_methods.dart';
import 'package:chatapp/views/conversations.dart';
import 'package:chatapp/views/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignUpParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=> UserRegBloc(),
      child: SignUp(),
    );
  }
}

class SignUp extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  UserRegBloc userRegBloc;

  @override
  Widget build(BuildContext context) {

      userRegBloc=BlocProvider.of<UserRegBloc>(context);
      DataBaseMethods dbMethods = new DataBaseMethods();

      return Scaffold(
        appBar: AppBar(title: Text('chat App' , style: TextStyle(color: Colors.black54),),),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          BlocListener<UserRegBloc,UserRegState>(
                            listener: (context , state) {
                              if(state is UserRegSuccessful) {
                                Map<String , String> userInfoMap = {
                                  "name" : userNameController.text,
                                  "email": emailController.text
                                };
                                dbMethods.uploadUserInfo(userInfoMap);
                                HelperFunctions.saveUserLoggedInsharedPreference(true);
                                HelperFunctions.saveUserNamesharedPreference( userNameController.text);
                                HelperFunctions.saveUserEmailsharedPreference(emailController.text);
                                HelperFunctions.saveUserIdsharedPreference(FirebaseAuth.instance.currentUser.uid);

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                      return Conversations();
                                    }));
                              }},
                            child: BlocBuilder<UserRegBloc,UserRegState>(
                              builder: (context , state){
                                if(state is UserRegInit)
                                {
                                  return Container(color: Colors.red,);
                                }
                                else if (state is UserLoadingState)
                                {
                                  return Container(color : Colors.blue);
                                }
                                else if (state is UserRegSuccessful)
                                {
                                  return Conversations();
                                }
                                else if (state is UserRegFailed)
                                {
                                  return Container(color: Colors.pink,);
                                }


                              },
                            ),
                          ),
                          TextFormField(
                            validator: (value){
                              return value.isEmpty? "please provide a username" : null;},
                            controller: userNameController,
                            decoration: InputDecoration(
                                hintText: 'Username'
                            ),
                          ),
                          TextFormField(
                            validator: (value){
                              return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
                              ).hasMatch(value) ? null : "invalid email address" ;
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (value){
                              return value.length<6 ? "password should not be less than 6 characters" : null ;
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
                                hintText: 'Password'
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16,),
                    FlatButton(
                      child:Text('Register'),
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if( formKey.currentState.validate())
                          userRegBloc.add(SignUpButtonPressedEvent(email: emailController.text, password: passwordController.text));
                        
                      },),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account ? ") ,
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder:(context){return SingInParent();} ));
                          },
                          child: Text("Sign In",
                            style: TextStyle(
                                decoration: TextDecoration.underline
                            ),),
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

