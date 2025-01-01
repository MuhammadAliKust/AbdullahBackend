import 'package:abdullah_backend/models/task_list.dart';
import 'package:abdullah_backend/services/task.dart';
import 'package:abdullah_backend/views/create_task.dart';
import 'package:abdullah_backend/views/get_completed.dart';
import 'package:abdullah_backend/views/get_in_completed.dart';
import 'package:abdullah_backend/views/search_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class GetAllTaskView extends StatefulWidget {
  const GetAllTaskView({super.key});

  @override
  State<GetAllTaskView> createState() => _GetAllTaskViewState();
}

class _GetAllTaskViewState extends State<GetAllTaskView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetCompletedTaskView()));
              },
              icon: Icon(Icons.circle)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetInCompletedTaskView()));
              },
              icon: Icon(Icons.star_half)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchView()));
              },
              icon: Icon(Icons.search)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskView()));
        },
        child: Icon(Icons.add),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: FutureProvider.value(
          value: TaskServices().getAllTask(
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzcyNDNhOWE1YTEwNTNlZTdlMTkwZDgiLCJpYXQiOjE3MzU1NDE2ODN9.Arlv21OQPKxz5PUse6vpf9YOn8t1Nl2GWxTk-lYr_I8'),
          initialData: TaskListModel(),
          builder: (context, child) {
            TaskListModel taskListModel = context.watch<TaskListModel>();
            return taskListModel.tasks == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: taskListModel.tasks!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(
                            taskListModel.tasks![i].description.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CupertinoSwitch(
                                value: taskListModel.tasks![i].complete!,
                                onChanged: (val) async {
                                  try {
                                    // await TaskServices().updateTask(token: token,
                                    //     taskID: taskID,
                                    //     description: description)
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(e.toString())));
                                  }
                                }),
                            IconButton(
                                onPressed: () async {
                                  isLoading = true;
                                  setState(() {});
                                  try {
                                    await TaskServices()
                                        .deleteTask(
                                            token:
                                                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzcyNDNhOWE1YTEwNTNlZTdlMTkwZDgiLCJpYXQiOjE3MzU1NDE2ODN9.Arlv21OQPKxz5PUse6vpf9YOn8t1Nl2GWxTk-lYr_I8',
                                            taskID: taskListModel.tasks![i].id
                                                .toString())
                                        .then((val) {
                                      isLoading = false;
                                      setState(() {});
                                    });
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(e.toString())));
                                  }
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                      );
                    });
          },
        ),
      ),
    );
  }
}
