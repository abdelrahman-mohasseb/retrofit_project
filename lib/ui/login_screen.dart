import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_project/Model/api_response.dart';
import 'package:retrofit_project/Model/login.dart';
import 'package:retrofit_project/repository/login_repository.dart';
import 'package:retrofit_project/ui/parts/circular_indicator.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool dataReady;
  late String messageToDisplay;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool register;

  @override
  void initState() {
    super.initState();
    messageToDisplay = "Loading ...";
    dataReady = false;
    register = false;
  }

  Widget titleWidget() {
    return Container(
      height: 75,
      width: 150,
      margin: const EdgeInsets.fromLTRB(100, 10, 100, 40),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.blue, width: 1.0, style: BorderStyle.solid),
        shape: BoxShape.rectangle,
      ),
      child: const Center(
          child: Text(
        "Login Screen",
        style: TextStyle(color: Colors.blue, fontSize: 24),
        maxLines: 1,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                titleWidget(),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: (register)
                        ? const Text(
                            'Register',
                            style: TextStyle(fontSize: 20),
                          )
                        : const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          )),
                (register)
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                      )
                    : const SizedBox(),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: Text((register) ? "Sign Up" : "Login"),
                      onPressed: () {
                        if (register) {
                          if (_formKey.currentState!.validate()) {
                            Login login = Login(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text);
                            ConnectToserver(login);
                          }
                        } else {
                          if (_formKey.currentState!.validate()) {
                            Login login = Login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            ConnectToserver(login);
                          }
                        }
                      },
                    )),
                Row(
                  children: <Widget>[
                    Text((register)
                        ? "Already have an account ?"
                        : 'Does not have account?'),
                    TextButton(
                      child: Text(
                        (register) ? "Sign in" : 'Register here',
                        style: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        (register == false)
                            ? setState(() {
                                register = true;
                              })
                            : setState(() {
                                register = false;
                              });
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )));
  }

  Future<bool> ConnectToserver(Login login) async {
    if (register) {
      LoginRepository _loginRepository = LoginRepository();
      return _loginRepository.register(login).then((result) {
        print(result.apiStatus.code);
        if (result.apiStatus.code != ApiResponseType.OK.code) {
          print(result.result);
          _showDialog("Registration Error", result.result);
          return false;
        }
        print("good");
        _showDialog("Registration Success", result.result);
        print(result.result);
        return true;
      });
    } else {
      LoginRepository _loginRepository = LoginRepository();
      return _loginRepository.signIn(login).then((result) {
        print(result.apiStatus.code);
        if (result.apiStatus.code != ApiResponseType.OK.code) {
          print(result.result);
          _showDialog("Connection Error", result.result);
          return false;
        }
        _showDialog("Connection Success", result.result);
        print("good");
        print(result.result);
        return true;
      });
    }
  }

  _showDialog(String title, String description) {
    if (Platform.isAndroid) {
      // set up the button
      Widget okButton = TextButton(
        child: const Text("OK"),
        onPressed: () async {
          Navigator.of(context, rootNavigator: true).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                child: Text(
              description,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ))),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      CupertinoAlertDialog alert = CupertinoAlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  child: Text(
                description,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ))),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
              },
            )
          ]);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
