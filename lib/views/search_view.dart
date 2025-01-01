import 'package:abdullah_backend/models/task_list.dart';
import 'package:abdullah_backend/services/task.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController controller = TextEditingController();

  TaskListModel? searchedTask;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search View"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            onSubmitted: (val) async {
              try {
                isLoading = true;
                setState(() {});
                await TaskServices()
                    .searchTask(
                        token:
                            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzcyNDNhOWE1YTEwNTNlZTdlMTkwZDgiLCJpYXQiOjE3MzU1NDE2ODN9.Arlv21OQPKxz5PUse6vpf9YOn8t1Nl2GWxTk-lYr_I8',
                        searchKey: controller.text)
                    .then((val) {
                  isLoading = false;
                  searchedTask = val;
                  setState(() {});
                });
              } catch (e) {
                isLoading = false;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (searchedTask != null)
            Expanded(
              child: searchedTask!.tasks!.isEmpty
                  ? Center(
                      child: Text("NO Data Found!"),
                    )
                  : ListView.builder(
                      itemCount: searchedTask!.tasks!.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          leading: Icon(Icons.task),
                          title: Text(
                              searchedTask!.tasks![i].description.toString()),
                        );
                      }),
            ),
        ],
      ),
    );
  }
}
