import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../ApiClients/dog_api_client.dart';
import '../Model/api_response.dart';

class DogRepository {
  final DogRestClient _client;

  DogRepository() : _client = DogRestClient(Dio());

  Future<ApiResponse> fetchAllDogsInformations(int limit) async {
    if (limit == null) {
      return ApiResponse(ApiResponseType.BadRequest, null);
    }

    // var response = await _client.getDogsBreedInformations(limit);

    return await _client
        .getDogsBreedInformations(limit)
        .then((value) => ApiResponse(ApiResponseType.OK, value))
        .catchError((e) {
      int errorCode = 0;
      String errorMessage = "";
      print(e);
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          if (res != null) {
            errorCode = res.statusCode!;
            errorMessage = res.statusMessage!;
          }
          break;
        default:
          errorMessage = e;
      }
      print("there is an error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, errorMessage);
    });
  }
}
