import 'package:flutter/material.dart';
import 'package:todo_app/shared/components/components.dart';

class TaskTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.indigo,
        child: Icon(
          Icons.add,
          ),
      ),
      backgroundColor: Colors.teal[400],
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          bottom: 80,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            Row(
              children: 
              [
                Icon(
                  Icons.playlist_add_check,
                  size: 40.0,
                  color: Colors.white,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    'ToDayDo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              ],
            ),
            Text(
              '5 task',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  )
                ),
                child: ListView(
                  children: 
                  [
                    ListTile(
                      title: Text(
                        'go To Gym',
                        ),
                        trailing: Checkbox(
                          value: false, 
                          onChanged:null,
                          ),
                    )
                  ],
                ),
              ),
            ),
            
            // ListView.separated(
            //   itemBuilder: (context , index) => tasksConditionBuilder(tasks: tasks), 
            //   separatorBuilder: (context , index) => myDivider(), 
            //   itemCount: 10)

          ],
        ),
      ),
    );
  }
}