import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:retrofit_project/Ui/splash_screen.dart';
import 'package:retrofit_project/ui/dog_list_screen.dart';
import 'package:retrofit_project/ui/login_screen.dart';

import '../Model/screen.dart';

// **************************************************************************************************************
// Provider to get the informations related to the screens defined in the app and the navigation process defined
// **************************************************************************************************************

const loginScreen = 0;
const dogListScreen = 1;

class NavigationProvider extends ChangeNotifier {
  /// Shortcut method for getting [NavigationProvider].
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);
  int _currentScreenIndex = loginScreen;

  int get currentTabIndex => _currentScreenIndex;

  /// Map to get each screen defined with a constate 

  final Map<int, Screen> _screens = {
    loginScreen: Screen(
      title: 'Login Screen',
      child: const LoginScreen(),
      initialRoute: LoginScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    dogListScreen: Screen(
      title: 'Dog Breeds',
      child: const DogListScreen(),
      initialRoute: DogListScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => const DogListScreen());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen? get currentScreen => _screens[_currentScreenIndex];

  /// sets the tab for the bottombar used to navigate between screens

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
      if (currentTabIndex != loginScreen) {
        setTab(loginScreen);
        notifyListeners();
        return false;
      } else {
        return await exitApplication(context);
      }
    }
  }

  
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    /// Push route without bottom navigation bar , use Navigator.of(context, rootNavigator: true).pushNamed(PushedScreen.route);
    /// Push route with bottom navigation bar, use Navigator.push();
    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }

 

  Future<bool> exitApplication(BuildContext context) {
    dynamic result;
    if (Platform.isAndroid) {
      result = showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Sad to see you leave so soon",
                textAlign: TextAlign.center),
            content: const Text("Do you want to exit the application?"),
            actions: <Widget>[
              TextButton(
                child: const Text("Yes"),
                onPressed: () async {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
              TextButton(
                child: const Text("No"),
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
              title: const Text("Sad to see you leave so soon",
                  textAlign: TextAlign.center),
              content: const Text("Do you want to exit the application?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("Yes"),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
                CupertinoDialogAction(
                  child: const Text("No"),
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
