
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/user/user_model.dart';
import 'package:todo_app/modules/register/cuibt/states.dart';




class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterIntialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);
  
  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,

  })
  {

    emit(RegisterLoadingStates());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, 
      password: password,
      ).then((value) 
      {
        createUser(
          email:email, 
          name: name, 
          phone: phone, 
          uId: value.user.uid,
          );
        print(value.user.uid);
        
      }).catchError((error)
      {
        print(error.toString());
        emit(RegisterErrorStates(error.toString()));
      });
  }

  void createUser({
    @required String email,
    @required String name,
    @required String phone,
    @required String uId,

  })
  {
    UserModel model=UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
     
    );

    FirebaseFirestore.instance
    .collection('users')
    .doc(uId).set(model.tomap()).then((value) 
    {
      emit(CreateUserSuccessStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(CreateUserErrorStates(error.toString()));
    });
  }

  IconData suffix= Icons.remove_red_eye_rounded;

  bool isPassword=true;

  void changeSuffixPassword()
  {
    isPassword = !isPassword;
    suffix= isPassword ?  Icons.remove_red_eye_rounded : Icons.visibility_off_outlined ;
    emit(RegisterChangePasswordVisibilityStates());
  }
}