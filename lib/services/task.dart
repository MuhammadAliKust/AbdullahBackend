import 'dart:convert';

import 'package:abdullah_backend/models/task.dart';
import 'package:abdullah_backend/models/task_list.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  String baseUrl = "https://todo-nu-plum-19.vercel.app/";

  ///Create Task
  Future<TaskModel> createTask(
      {required String description, required String token}) async {
    http.Response response = await http.post(Uri.parse('${baseUrl}todos/add'),
        headers: {'Content-Type': 'application/json',
        'Authorization':token},
        body: jsonEncode({"description": description}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Get All Task
  Future<TaskListModel> getAllTask(String token) async {
    http.Response response = await http.get(
      Uri.parse('${baseUrl}todos/get'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListModel.fromJson(jsonDecode(response.body));
    } else {
      throw 'Something went wrong';
    }
  }

  ///Get Completed Task
  Future<TaskListModel> getCompletedTask(String token) async {
    http.Response response = await http.get(
      Uri.parse('${baseUrl}todos/completed'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListModel.fromJson(jsonDecode(response.body));
    } else {
      throw 'Something went wrong';
    }
  }

  ///Get InCompleted Task
  Future<TaskListModel> getInCompletedTask(String token) async {
    http.Response response = await http.get(
      Uri.parse('${baseUrl}todos/incomplete'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListModel.fromJson(jsonDecode(response.body));
    } else {
      throw 'Something went wrong';
    }
  }

  ///Search Task
  Future<TaskListModel> searchTask(
      {required String token, required String searchKey}) async {
    http.Response response = await http.get(
      Uri.parse('${baseUrl}todos/search?keywords=$searchKey'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListModel.fromJson(jsonDecode(response.body));
    } else {
      throw 'Something went wrong';
    }
  }

  ///Delete Task
  Future<bool> deleteTask(
      {required String token, required String taskID}) async {
    http.Response response = await http.delete(
      Uri.parse('${baseUrl}todos/delete/$taskID'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw 'Something went wrong';
    }
  }

  ///Update Task
  Future<bool> updateTask(
      {required String token,
      required String taskID,
      required String description}) async {
    http.Response response = await http.patch(
        Uri.parse('${baseUrl}todos/update/$taskID'),
        headers: {'Authorization': token},
        body: {"description": description, "complete": true});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw 'Something went wrong';
    }
  }
}
