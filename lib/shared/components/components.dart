import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/shared/components/constans.dart';

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

var direction = DismissDirection.endToStart;
Widget buildTaskItem(Map model, context) => Dismissible(
      direction: direction,
      key: Key(model['id'].toString()),
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
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text("${model['time']}"),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${model['date']}",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(width: 20),
            IconButton(
              color: Colors.green,
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: Icon(Icons.check_box),
            ),
            IconButton(
              color: Colors.grey,
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archive', id: model['id']);
              },
              icon: Icon(Icons.archive),
            )
          ],
        ),
      ),
    );

Widget tasksConditionBuilder({@required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => SingleChildScrollView(
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: tasks.length,
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
