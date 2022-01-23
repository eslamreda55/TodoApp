import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/shared/components/constants.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required Function validate,
  @required IconData prefixIcon,
  @required String label,
  bool isPassword = false,
  IconData sufix,
  String hintText,
  Function onsubmited,
  Function onchange,
  Function onTab,
  Function sufixOnPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      obscureText: isPassword,
      onFieldSubmitted: onsubmited,
      onChanged: onchange,
      onTap: onTab,
      decoration: InputDecoration(
        suffixIcon: sufix != null
            ? IconButton(
                onPressed: sufixOnPressed,
                icon: Icon(sufix),
              )
            : null,
        prefixIcon: Icon(prefixIcon),
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );


  Widget defaultAppBar({
  @required BuildContext context,
  Color background = defaultColor,
  String title,
  List<Widget> actions,
})
{
  return AppBar(
    backgroundColor: background,
    leading:IconButton(
      onPressed: ()
      {
        Navigator.pop(context);
      }, 
      icon: Icon(Icons.arrow_back),
      ) ,
    title: Text(
      title,  
     ),
    titleSpacing: 5.0,
    actions: actions,
    );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  @required Function onPressed,
  @required String text,
  bool isUpperCase = false,
  double raduis = 0.0,
  Null Function() function,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void showToast({
      @required String text,
      @required toastState state,
      
    })=>
     Fluttertoast.showToast(
      msg:text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_LEFT,
      timeInSecForIosWeb: 4,
      backgroundColor: chooseToastColor(state) ,
      textColor: Colors.white,
      fontSize: 16.0
      );

  enum toastState{SUCCESS,ERROR,WARNING}  
  Color chooseToastColor(toastState state)
  {
    Color color;

    switch(state)
    {
      case toastState.SUCCESS:
      color= Colors.green;
      break;
      case toastState.ERROR:
        color= Colors.red;
        break;
      case toastState.WARNING:
        color= Colors.yellowAccent;
        break;
    }
    return color;

  }



var direction = DismissDirection.endToStart;
Widget buildTaskItem(TaskModel model, context) => Dismissible(
      direction: direction,
      key: Key(model.uId),
      background: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            )
          ],
        ),
        color: Colors.red,
      ),
      onDismissed: (direction) {
        //AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(
                "${model.time}",
                style: TextStyle(
                  fontSize: 14.0
                ),
                textAlign: TextAlign.center,
                ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model.title}",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${model.date}",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(width: 5),
            IconButton(
              color: Colors.green,
              onPressed: () {
                // AppCubit.get(context)
                //     .updateData(status: 'done', id: model['id']);
              },
              icon: Icon(Icons.check_box),
            ),
            IconButton(
              color: Colors.grey,
              onPressed: () {
                // AppCubit.get(context)
                //     .updateData(status: 'archive', id: model['id']);
              },
              icon: Icon(Icons.archive),
            ),
            IconButton(
              color: Colors.grey,
              onPressed: () {
                // AppCubit.get(context)
                //     .updateData(status: 'edite', id: model['id']);
              },
              icon: Icon(Icons.edit),
            )
          ],
        ),
      ),
    );


Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        color: Colors.grey[300],
        height: 1.0,
      ),
    );

  Widget defaultTextButton({
    @required Function onPressed,
    @required String text,
  })
  =>TextButton(
    onPressed: onPressed,
    child: Text(text.toUpperCase(),
            style: TextStyle(
              color:Colors.indigo,
              fontSize: 15.0,
            ),
      )
    );


void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
   MaterialPageRoute(
        builder: (context) => widget,
      ), 
   (route) => false,

   );


Widget tasksConditionBuilder(tasks ,context) => 
ConditionalBuilder(
      condition: AppCubit.get(context).tasks.length > 0,
      builder: (context) => SingleChildScrollView(
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildTaskItem(AppCubit.get(context).tasks[index], context),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount: AppCubit.get(context).tasks.length,
            ),
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              'No tasks added yet , please add some tasks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
