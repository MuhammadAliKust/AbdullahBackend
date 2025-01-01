import 'dart:developer';

import 'package:abdullah_backend/services/auth.dart';
import 'package:abdullah_backend/views/create_task.dart';
import 'package:abdullah_backend/views/get_all_task.dart';
import 'package:abdullah_backend/views/register.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: pwdController,
          ),
          SizedBox(
            height: 30,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    try {
                      isLoading = true;
                      setState(() {});
                      await AuthServices()
                          .login(
                              email: emailController.text,
                              password: pwdController.text)
                          .then((val) async {
                        await AuthServices()
                            .getUserProfile(val.token.toString())
                            .then((user) {
                          isLoading = false;
                          setState(() {});
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetAllTaskView()));
                          log(val.token.toString());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(user.user!.name.toString())));
                        });
                      });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Login")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterView()));
              },
              child: Text("Register"))
        ],
      ),
    );
  }
}
