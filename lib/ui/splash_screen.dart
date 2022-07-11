import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrofit_project/Providers/dog_provider.dart';
import 'package:retrofit_project/ui/parts/circular_indicator.dart';

import '../Providers/navigation_provider.dart';

// *************************************** 
// the screen at the begining of the app
// ***************************************

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final dogProvider = context.watch<DogProvider>();
    return FutureBuilder(
        future: getDogsInformations( dogProvider),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
                body: Center(
                    child: CircularIndicator("Loading...")));
          } 
            else {
              return Consumer<NavigationProvider>(
                  builder: (context, provider, child) {
                return WillPopScope(
                    onWillPop: () => provider.onWillPop(context),
                    child: Scaffold(
                        body:  IndexedStack(
                              children: provider.screens
                                  .map(
                                    (screen) => Offstage(
                                      offstage:
                                          screen != provider.currentScreen,
                                      child: Navigator(
                                        key: screen.navigatorState,
                                        onGenerateRoute: screen.onGenerateRoute,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              index: provider.currentTabIndex,
                            ),
                           
                        bottomNavigationBar: Container(
                          height: 90,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
                          ),
                          child: BottomNavigationBar(
                            items: [
                              BottomNavigationBarItem(
                                 icon: const Icon(
                                    Icons.login,
                                  ),
                                  label:  provider.screens[0].title
                                     ),
                              BottomNavigationBarItem(
                                  icon: const Icon(
                                    Icons.list,
                                  ),
                                  label: provider.screens[1].title
                                     ),
                            ],
                            currentIndex: provider.currentTabIndex,
                            onTap: provider.setTab,
                            type: BottomNavigationBarType.fixed,
                            unselectedLabelStyle: const TextStyle(
                                fontSize: 14, overflow: TextOverflow.visible),
                            selectedItemColor:  Colors.blue,
                            unselectedItemColor:
                               Colors.black  ,
                            selectedIconTheme: const IconThemeData(
                              color:  Colors.blue ,
                            ),
                            unselectedIconTheme: const IconThemeData(
                                color:  Colors.black ,
                          ),
                        ))));
              });
            
          }
          
        });
  }

  Future<bool> getDogsInformations(
           DogProvider dogProvider) =>
      Future.delayed(const Duration(seconds: 2), () async {
        var response = dogProvider.fetchDogsInformations();
        return response;
      });
}
