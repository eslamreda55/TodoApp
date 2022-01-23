import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/modules/login/cubit/cubit.dart';
import 'package:todo_app/modules/login/cubit/states.dart';
import 'package:todo_app/modules/register/register_screen.dart';
import 'package:todo_app/shared/network/local/cash_helper.dart';

class LoginScreen extends StatelessWidget {

  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey = GlobalKey<FormState>();
   
  @override
  Widget build(BuildContext context) {
       return BlocProvider(
         create: (BuildContext context) => LoginCubit(),
         child: BlocConsumer<LoginCubit , LoginStates>(
           listener: (context , state)
           {
            if(state is LoginSuccessStates)
            {
              CasheHelper.saveData(
                key: 'uId', 
                value:state.uId ,
                ).then((value) 
                {
                  navigateAndFinish(context, HomeLayout());
                });
          }
           },
           builder: (context , state)=>
           Scaffold(
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
                                'LOGIN',
                                style: Theme.of(context).textTheme.headline4.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'login Now to Make new Tasks',
                                style: Theme.of(context).textTheme.bodyText1.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              defaultFormField(
                                prefixIcon: Icons.email ,
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                  validate: (String value)
                                  {
                                    if(value.isEmpty){
                                      return 'email must not to be empty';
                                    }
                                  },
                                    label: 'Email Address',
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    defaultFormField(
                                      controller: passwordController,
                                      prefixIcon:  Icons.lock_open ,
                                      type: TextInputType.visiblePassword,
                                        validate: (String value)
                                        {
                                          if(value.isEmpty){
                                            return 'password is too short';
                                          }
                                        },
                                      isPassword: LoginCubit.get(context).isPassword,
                                      onsubmited: (value)
                                      {
                                        if(formKey.currentState.validate())
                                            {
                                            LoginCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              );
                                            }
                                      },
                                      sufix:LoginCubit.get(context).suffix,
                                      sufixOnPressed:()
                                      {
                                        LoginCubit.get(context).changeSuffixPassword();
                                      } ,
                                      label: 'Password',
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                  ConditionalBuilder(
                                    condition:state is! LoginLoadingStates ,
                                     builder: (context)=> defaultButton(
                                      onPressed: ()
                                      {
                                        if(formKey.currentState.validate())
                                        {
                                        LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                           password: passwordController.text,
                                           );
                                        }
                                      },
                                      text: 'LOGIN',
                                      isUpperCase: true,
                                      ),
                                     fallback: (context)=>Center(child: CircularProgressIndicator()),
                                     ),
                                     
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: 
                                      [
                                        Text('Don\'t have an account?'),
                                        defaultTextButton(
                                          onPressed: ()
                                          {
                                            navigateTo(context, RegisterScreen(),);
                                          },
                                          text: 'Register Now' ,
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
         ),
       );
      }
   
}