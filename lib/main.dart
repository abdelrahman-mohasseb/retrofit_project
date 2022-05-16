import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:retrofit_project/Providers/dog_provider.dart';
import 'package:retrofit_project/Ui/splash_screen.dart';

import 'Providers/navigation_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState._privateConstructor();
  static final _MyAppState _instance = _MyAppState._privateConstructor();
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  factory _MyAppState() {
    return _instance;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DogProvider()),
          ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
              title: "Dog Application",
              onGenerateTitle: (context) => "Dog Application",
              //onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
              //navigatorKey: GlobalVariable.navState,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: SplashScreen());
        }));
  }
}
