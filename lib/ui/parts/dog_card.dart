import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_project/model/dog.dart';
import 'package:retrofit_project/ui/parts/circular_indicator.dart';

// **********************************************************************************************
// Dog card model represents how all the details of a the dog breed are shown in each list element
// **********************************************************************************************

class DogCard extends StatefulWidget {
  final void Function(Dog) seeDetail;
  final Dog dog;

  const DogCard({
    Key? key,
    required this.dog,
    required this.seeDetail,
  }) : super(key: key);
  @override
  _OffreCardState createState() => _OffreCardState();
}

class _OffreCardState extends State<DogCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.seeDetail(widget.dog);
        },
        child: Container(
            height: 160,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.black, width: 1.0, style: BorderStyle.solid),
            ),
            child: Row(children: [
              SizedBox(
                  width: 150,
                  child: Center(
                    child: ClipRRect(
                      child: (widget.dog.dogImageURL != "")
                          ? CachedNetworkImage(
                              imageUrl: widget.dog.dogImageURL,
                              width: 150,
                              height: 150,
                              fit: BoxFit.fitWidth,
                              placeholder: (context, url) =>
                                  const CircularIndicator("Loading ..."),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/dogs.png",
                                width: 150,
                                height: 150,
                                fit: BoxFit.fitWidth,
                              ),
                            )
                          : Container(
                              color: Colors.yellow,
                              width: 150,
                              height: 150,
                            ),
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: (widget.dog.name != null)
                          ? Text(
                              widget.dog.name!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          : const Text(
                              " dog Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )))
            ])));
  }
}
