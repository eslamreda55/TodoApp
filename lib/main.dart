import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/modules/login/login_screen.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/components/constans.dart';
import 'package:todo_app/shared/network/local/cash_helper.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  await CasheHelper.init();

  Widget widget;
   if(uId !=null)
    {
      widget = HomeLayout();
    }else
    {
      widget = LoginScreen();
    }

  runApp(MyApp(
    startWidget :widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  const MyApp({Key key, this.startWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo app',
        theme: ThemeData(
          primarySwatch: defaultColor,
        ),
        home: startWidget,
      ),
    );
  }
}


