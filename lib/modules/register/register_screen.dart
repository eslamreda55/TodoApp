import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/models/user/user_model.dart';
import 'package:todo_app/modules/login/login_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/modules/register/cuibt/cubit.dart';
import 'package:todo_app/modules/register/cuibt/states.dart';


class RegisterScreen extends StatelessWidget {

  UserModel userModel;

  var formKey = GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer< RegisterCubit , RegisterStates>(
        listener:(context,state) 
        {
          if(state is CreateUserSuccessStates)
          {
            navigateAndFinish(context, HomeLayout());
          }
        } ,
        builder:(context , state)
        {
          return Scaffold(
           body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: 
                          [
                            Text(
                              'REGISTER',
                              style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Register Now to make our tasks',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                                validate: (String value)
                                {
                                  if(value.isEmpty){
                                    return 'name must not to be empty';
                                  }
                                },
                                prefixIcon: Icons.person_add_alt,
                                  label: 'User Name',
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                  validate: (String value)
                                  {
                                    if(value.isEmpty){
                                      return 'email must not to be empty';
                                    }
                                  },
                                  prefixIcon: Icons.email,
                                    label: 'Email Address',
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  defaultFormField(
                                    controller: passwordController,
                                    type: TextInputType.visiblePassword,
                                      validate: (String value)
                                      {
                                        if(value.isEmpty){
                                          return 'password is too short';
                                        }
                                      },
                                    isPassword: RegisterCubit.get(context).isPassword,
                                    onsubmited: (value)
                                    {
                                     
                                    },
                                    prefixIcon: Icons.lock_open,
                                    sufix:RegisterCubit.get(context).suffix,
                                    sufixOnPressed:()
                                    {
                                      RegisterCubit.get(context).changeSuffixPassword();
                                    } ,
                                    label: 'Password',
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                                validate: (String value)
                                {
                                  if(value.isEmpty){
                                    return 'phone must not to be empty';
                                  }
                                },
                                prefixIcon: Icons.phone,
                                  label: 'Phone Number',
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                ConditionalBuilder(
                                  condition:state is! RegisterLoadingStates  ,
                                   builder: (context)=> defaultButton(
                                    onPressed: ()
                                    {
                                        if(formKey.currentState.validate())
                                        {
                                        RegisterCubit.get(context).userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          );
                                        }
                                      
                                    },
                                    text: 'REGISTER',
                                    isUpperCase: true,
                                    ),
                                   fallback: (context)=>Center(child: CircularProgressIndicator()),
                                   ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
        }
      ),
    );
  }
}