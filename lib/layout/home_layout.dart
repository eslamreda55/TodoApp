import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/models/user/user_model.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

   UserModel userModel;
   HomeLayout({
     this.userModel,
  }) ;

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<AppCubit, AppStates>(
          listener: ( context,  states) {},
          builder: ( context,  states) {
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
                condition:true ,//State is! AppGetDataBaseLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.indigo,    
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState.validate()) {
                      cubit.createNewTask(
                        description: descriptionController.text,
                        date: dateController.text,
                        time: timeController.text,
                        title: titleController.text,
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
                                      prefixIcon:  Icons.title ,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "Title must not be empty";
                                        }
                                        return null;
                                      },
                                      label: "Task Title",
                                      ),
                                      SizedBox(height: 15),
                                      defaultFormField(
                                      prefixIcon: Icons.title ,
                                      controller: descriptionController,
                                      type: TextInputType.text,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "description must not be empty";
                                        }
                                        return null;
                                      },
                                      label: "Task description",
                                      ),
                                  SizedBox(height: 15),
                                  defaultFormField(
                                      prefixIcon: Icons.watch_later_outlined,
                                      controller: timeController,
                                      type: TextInputType.datetime,
                                      onTab: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) => timeController.text =
                                            value.format(context)
                                            );
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "time must not be empty";
                                        }
                                        return null;
                                      },
                                      label: "Task Time",
                                      ),
                                  SizedBox(height: 15),
                                  defaultFormField(
                                      prefixIcon: Icons.calendar_today ,
                                      controller: dateController,
                                      type: TextInputType.datetime,
                                      onTab: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2022-05-09',
                                                    ),
                                                    )
                                            .then((value) =>
                                                dateController.text =
                                                    DateFormat.yMMMd()
                                                        .format(value)
                                                        );
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "date must not be empty";
                                        }
                                        return null;
                                      },
                                      label: "Task Date",
                                      ),
                                ],
                              ),
                            ),
                          ),
                          elevation: 20.0,
                        )
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                          isShow: false, icon: Icons.edit
                          );
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
        );
      }
    );
  }
}
