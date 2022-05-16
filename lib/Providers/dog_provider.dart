import 'package:flutter/material.dart';
import 'package:retrofit_project/Model/api_response.dart';
import 'package:retrofit_project/Model/dog.dart';
import 'package:retrofit_project/repository/dog_repository.dart';

class DogProvider extends ChangeNotifier {
  int limit = 10;
  List<Dog> dogsInformations = [];

  dogProvider() {}

  Future<bool> fetchDogsInformations(BuildContext context) async {
    DogRepository _dogRepository = DogRepository();
    return _dogRepository.fetchAllDogsInformations(limit).then((result) {
      print(result.apiStatus.code);
      if (result.apiStatus.code != ApiResponseType.OK.code) {
        print("Not good");
        return false;
      }
      print("good");
      dogsInformations.addAll(result.result);
      print(dogsInformations.length);
      return true;
    });
  }
}
