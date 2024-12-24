import 'dart:convert';

import 'package:abdullah_backend/models/login.dart';
import 'package:abdullah_backend/models/register.dart';
import 'package:abdullah_backend/models/user.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  String baseUrl = "https://todo-nu-plum-19.vercel.app/";

  ///Register User
  Future<RegisterModel> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    http.Response response = await http.post(
        Uri.parse('${baseUrl}users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, "email": email, "password": password}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Login User
  Future<LoginModel> login(
      {required String email, required String password}) async {
    http.Response response = await http.post(Uri.parse('${baseUrl}users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Get User Profile
  Future<UserModel> getUserProfile(String token) async {
    http.Response response = await http.get(
      Uri.parse('${baseUrl}users/profile'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw 'Something went wrong';
    }
  }
}
