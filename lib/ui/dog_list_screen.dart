import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrofit_project/Model/dog.dart';
import 'package:retrofit_project/ui/parts/dog_card.dart';

import '../Providers/dog_provider.dart';

class DogListScreen extends StatefulWidget {
  static const route = '/dogList';
  @override
  _DogListScreenState createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
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
        "DOGS LIST",
        style: TextStyle(color: Colors.blue, fontSize: 24),
        maxLines: 1,
      )),
    );
  }

  Widget noDogs() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.block,
            size: 60,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Les chiens sont disparus du monde !",
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dogProvider = context.watch<DogProvider>();
    return SafeArea(
        child: Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Column(children: [
                      titleWidget(),
                      (dogProvider.dogsInformations.isNotEmpty)
                          ? ListView.builder(
                              physics:
                                  const NeverScrollableScrollPhysics(), // to disable ListView's scrolling
                              shrinkWrap: true,
                              itemCount: dogProvider.dogsInformations.length,
                              itemBuilder: (BuildContext context, int index) {
                                return DogCard(
                                  dog: dogProvider.dogsInformations[index],
                                  seeDetail: seeDetail,
                                );
                              },
                            )
                          : noDogs()
                    ])
                  ],
                ))));
  }

  seeDetail(Dog dog) async {
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
        title: Text(dog.name!, textAlign: TextAlign.center),
        content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: [
                  (dog.referenceImageID != null && dog.referenceImageID != "")
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(dog.dogImageURL)),
                          ),
                        )
                      : const SizedBox(),
                  (dog.lifeSpan != null && dog.lifeSpan != "")
                      ? Text(
                          "Average age : " + dog.lifeSpan!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox(),
                  (dog.bredFor != null && dog.bredFor != "")
                      ? Text(
                          "This dog is bred for : " + dog.bredFor!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox(),
                  (dog.origin != null && dog.origin != "")
                      ? Text(
                          "This dog is from : " + dog.origin!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox(),
                  (dog.height != null && dog.height!.metric != "")
                      ? Text(
                          "Height : " + (dog.height!.imperial)! + " cm",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox(),
                  (dog.height != null && dog.height!.metric != "")
                      ? Text(
                          "Weight : " + (dog.weight!.metric)! + " kg",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox(),
                ],
              ),
              alignment: Alignment.center,
              margin: MediaQuery.of(context).viewInsets,
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
          title: Text(dog.name!, textAlign: TextAlign.center),
          content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  children: [
                    (dog.referenceImageID != null && dog.referenceImageID != "")
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(dog.dogImageURL)),
                            ),
                          )
                        : const SizedBox(),
                    (dog.lifeSpan != null && dog.lifeSpan != "")
                        ? Text(
                            "Average age : " + dog.lifeSpan!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox(),
                    (dog.bredFor != null && dog.bredFor != "")
                        ? Text(
                            "This dog is bred for : " + dog.bredFor!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox(),
                    (dog.origin != null && dog.origin != "")
                        ? Text(
                            "This dog is from : " + dog.origin!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox(),
                    (dog.height != null && dog.height!.metric != "")
                        ? Text(
                            "Height : " + (dog.height!.imperial)! + " cm",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox(),
                    (dog.height != null && dog.height!.metric != "")
                        ? Text(
                            "Weight : " + (dog.weight!.metric)! + " kg",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox(),
                  ],
                ),
                alignment: Alignment.center,
                margin: MediaQuery.of(context).viewInsets,
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
