import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:retrofit_project/Ui/splash_screen.dart';
import 'package:retrofit_project/ui/dog_list_screen.dart';
import 'package:retrofit_project/ui/login_screen.dart';

import '../Model/Screen.dart';

const login_screen = 0;
const dog_list_screen = 1;

class NavigationProvider extends ChangeNotifier {
  /// Shortcut method for getting [NavigationProvider].
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);
  int _currentScreenIndex = login_screen;

  int get currentTabIndex => _currentScreenIndex;

  final Map<int, Screen> _screens = {
    login_screen: Screen(
      title: 'Login Screen',
      child: LoginScreen(),
      initialRoute: LoginScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => LoginScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    dog_list_screen: Screen(
      title: 'Dog Breeds',
      child: DogListScreen(),
      initialRoute: DogListScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => DogListScreen());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen? get currentScreen => _screens[_currentScreenIndex];

  void setTab(int tab) {
    if (tab == currentTabIndex) {
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    // return false means that we handle what to do when user presses the back button
    // return true means the system will handle what do when user presses the back button
    final currentNavigatorState = currentScreen!.navigatorState.currentState;

    if (currentNavigatorState!.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != login_screen) {
        setTab(login_screen);
        notifyListeners();
        return false;
      } else {
        return await exitApplication(context);
      }
    }
  }

  //
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // Push route without bottom navigation bar , we use Navigator.of(context, rootNavigator: true).pushNamed(PushedScreen.route);
    // Push route with bottom navigation bar, we use Navigator.push();
    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }

  Future<bool> exitApplication(BuildContext context) {
    var result;
    if (Platform.isAndroid) {
      result = showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Vous etes sur ?", textAlign: TextAlign.center),
            content: const Text("Voulez vous quitter l'application ?"),
            actions: <Widget>[
              TextButton(
                child: const Text("Oui"),
                onPressed: () async {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
              TextButton(
                child: const Text("Non"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        },
      );
    } else {
      result = showCupertinoDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text("Vous etes sur ?", textAlign: TextAlign.center),
              content: const Text("Voulez vous quitter l'application ?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("Oui"),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
                CupertinoDialogAction(
                  child: const Text("Non"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          });
    }
    return result;
  }
}
