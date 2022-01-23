import 'package:flutter/material.dart';
import 'package:todo_app/modules/login/login_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/network/local/cash_helper.dart';

const defaultColor = Colors.teal;

void signOut(context)
{
   CasheHelper.removeData(key: 'uId').then((value) 
            {
              if(value)
              {
                navigateAndFinish(context, LoginScreen(),);
              }
            }
            );
}



String uId='';

// void creatTask()
// {
//   DocumentReference documentReference =
//   FirebaseFirestore.instance
//   .collection('tasks')
//   .doc('input');

//   Map<String , String> tasks = 
//   {
//     'tasktitle' : input,
//   };
//   documentReference.set({
//     'task' : true,
//   }).whenComplete(() 
//   {
//     print('$input created');
//   });
// }

// void deleteTask()
// {
  
// }

// void updateTask()
// {
  
// }

// void archivedTask()
// {
  
// }