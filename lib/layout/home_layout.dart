import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/layout/cubit/states.dart';
import 'package:todo_app/models/user/user_model.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constans.dart';

class HomeLayout extends StatelessWidget {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  UserModel userModel;
   HomeLayout({
     this.userModel,
  }) ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates states) {
            if (State is AppInsertDataBaseState) {
              Navigator.pop(context);
            }
          },
          builder: (BuildContext context, AppStates states) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: defaultAppBar(
                context: context,
                title: cubit.titles[cubit.currentIndex],
                actions: 
                [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20.0
                    ),
                    child: defaultTextButton(
                      onPressed: ()
                      {
                        signOut(context);
                      }, 
                      text: 'LOGOUT',
                      ),
                  ),
                ]
                ),
              body: ConditionalBuilder(
                condition: State is! AppGetDataBaseLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState.validate()) {
                      cubit.insertToDatabase(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text,
                          );
                          Navigator.pop(context);
                          descriptionController.clear();
                          titleController.clear();
                          timeController.clear();
                          dateController.clear();
                          cubit.changeBottomSheetState(
                          icon: Icons.edit,
                          isShow: false,
                          );
                    }
                  } else {
                    scaffoldKey.currentState
                        .showBottomSheet(
                          (context) => Container(
                            color: Colors.grey[200],
                            padding: EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                      controller: titleController,
                                      type: TextInputType.text,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "Title must not be empty";
                                        }
                                        return null;
                                      },
                                      label: "Task Title",
                                      prefixIcon: Icons.title),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    controller: descriptionController,
                                    decoration: InputDecoration(
                                      hintText: 'Task description',
                                    ),
                                    validator:  (String value)
                                    {
                                     if (value.isEmpty) {
                                        return "Title must not be empty";
                                      }
                                      return null; 
                                    } ,
                                  ),
                                  SizedBox(height: 15),
                                  defaultFormField(
                                      controller: timeController,
                                      type: TextInputType.datetime,
                                      onTab: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) => timeController.text =
                                            value.format(context));
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "time must not be empty";
                                        }
                                        return null;
                                      },
                                      label: "Task Time",
                                      prefixIcon: Icons.watch_later_outlined),
                                  SizedBox(height: 15),
                                  defaultFormField(
                                      controller: dateController,
                                      type: TextInputType.datetime,
                                      onTab: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2022-05-09'))
                                            .then((value) =>
                                                dateController.text =
                                                    DateFormat.yMMMd()
                                                        .format(value));
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "date must not be empty";
                                        }
                                        return null;
                                      },
                                      label: "Task Date",
                                      prefixIcon: Icons.calendar_today),
                                ],
                              ),
                            ),
                          ),
                          elevation: 20.0,
                        )
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    });

                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  }
                },
                child: Icon(cubit.fabIcon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                  // setState(() {
                  //   currentIndex = index;
                  // });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived',
                  )
                ],
              ),
            );
          },
        ));
  }
}
