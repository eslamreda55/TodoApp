import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginIntialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    @required String email,
    @required String password,

  })
  {

    emit(LoginLoadingStates());

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: password,
      ).then((value) 
      {
        print(value.user.email);
        print(value.user.uid);
        emit(LoginSuccessStates(value.user.uid));
      }).catchError((error)
      {
        emit(LoginErrorStates(error.toString()));
      });
  }

  // void signOut()
  // {
  //   FirebaseAuth.instance.signOut();
  // }

  IconData suffix= Icons.remove_red_eye_rounded;

  bool isPassword=true;

  void changeSuffixPassword()
  {
    
    isPassword = !isPassword;

    suffix= isPassword ?  Icons.remove_red_eye_rounded : Icons.visibility_off_outlined ;
    emit(ChangePasswordVisibilityStates());
  }
}