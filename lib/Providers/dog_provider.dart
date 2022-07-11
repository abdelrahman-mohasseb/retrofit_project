import 'package:flutter/material.dart';
import 'package:retrofit_project/model/api_response.dart';

import 'package:retrofit_project/repository/dog_repository.dart';

import '../model/dog.dart';

// *********************************************************************************************
// Provider to get the methods related to the dog api in any place in the app where it is needed
// **********************************************************************************************

class DogProvider extends ChangeNotifier {
  List<Dog> dogsInformations = [];

  dogProvider() {}

  /// gets the data from the api and returns a bool.
  ///
  /// result is false when the api response status code is not 200.
  /// result is true when api response is 200

  Future<bool> fetchDogsInformations() async {
    DogRepository _dogRepository = DogRepository();
    return _dogRepository.fetchAllDogsInformations().then((result) {
      if (result.apiStatus.code != ApiResponseType.ok.code) {
        return false;
      } else {
        dogsInformations.addAll(result.result);
        return true;
      }
    });
  }
}
