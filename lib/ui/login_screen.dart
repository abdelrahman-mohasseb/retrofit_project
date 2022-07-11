import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_project/model/api_response.dart';

import 'package:retrofit_project/repository/login_repository.dart';

import '../model/login.dart';

// ******************************************************
// the tab representing the login or resgister of a user
// ******************************************************

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool dataReady;
  late String messageToDisplay;
  late bool loginIsSuccess;
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
    loginIsSuccess = false;
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
        child: (!loginIsSuccess)
            ? Form(
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
                          if (!(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text))) {
                            return 'Please enter a valid email';
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
                          onPressed: () async {
                            if (register) {
                              if (_formKey.currentState!.validate()) {
                                Login login = Login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text);
                                var result = await connectToserver(login);
                                if (result) {
                                  setState(() {
                                    register = false;
                                  });
                                }
                              }
                            } else {
                              if (_formKey.currentState!.validate()) {
                                Login login = Login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                var result = await connectToserver(login);
                                if (result) {
                                  setState(() {
                                    loginIsSuccess = true;
                                  });
                                }
                              }
                            }
                          },
                        )),
                    Row(
                      children: <Widget>[
                        Text((register)
                            ? "Already have an account ?"
                            : "Doesn't have account?"),
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
                ))
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Welcome to your account !",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        loginIsSuccess = false;
                      });
                    },
                    child: Container(
                      width: 140,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Disconnect",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )));
  }

  Future<bool> connectToserver(Login login) async {
    if (register) {
      LoginRepository _loginRepository = LoginRepository();
      return _loginRepository.register(login).then((result) {
        if (result.apiStatus.code != ApiResponseType.ok.code) {
          _showDialog("Registration Error", result.result);
          return false;
        } else {
          _showDialog("Registration Success", result.result);
          return true;
        }
      });
    } else {
      LoginRepository _loginRepository = LoginRepository();
      return _loginRepository.signIn(login).then((result) {
        if (result.apiStatus.code != ApiResponseType.ok.code) {
          _showDialog("Connection Error", result.result);
          return false;
        } else {
          //_showDialog("Connection Success", result.result);
          return true;
        }
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
            child: Text(
              description,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            )),
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
              child: Text(
                description,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              )),
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
