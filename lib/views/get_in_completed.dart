import 'package:abdullah_backend/models/task_list.dart';
import 'package:abdullah_backend/services/task.dart';
import 'package:abdullah_backend/views/create_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetInCompletedTaskView extends StatelessWidget {
  const GetInCompletedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get In Completed Task"),
      ),
      body: FutureProvider.value(
        value: TaskServices().getInCompletedTask(
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzcyNDNhOWE1YTEwNTNlZTdlMTkwZDgiLCJpYXQiOjE3MzU1NDE2ODN9.Arlv21OQPKxz5PUse6vpf9YOn8t1Nl2GWxTk-lYr_I8'),
        initialData: TaskListModel(),
        builder: (context, child) {
          TaskListModel taskListModel = context.watch<TaskListModel>();
          return taskListModel.tasks == null
              ? Center(
            child: CircularProgressIndicator(),
          )
              :  ListView.builder(
              itemCount: taskListModel.tasks!.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(taskListModel.tasks![i].description.toString()),
                );
              });
        },
      ),
    );
  }
}
