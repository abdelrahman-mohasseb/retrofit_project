import 'package:dio/dio.dart';
import 'package:retrofit_project/model/api_response.dart';
import '../ApiClients/dog_api_client.dart';

// ********************************************************************************************************************************************
// Dog repository to respect the MVVM architecture and seperate how the data is fetched from the server and the view that represents the data
// ********************************************************************************************************************************************


class DogRepository {
  final DogRestClient _client;

  DogRepository() : _client = DogRestClient(Dio());

  /// handles the apiResponse to get the result in case of success and error

  Future<ApiResponse> fetchAllDogsInformations() async {
    return await _client
        .getDogsBreedInformations()
        .then((value) => ApiResponse(ApiResponseType.ok, value))
        .catchError((e) {
      int errorCode = 0;
      String errorMessage = "";
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
      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, errorMessage);
    });
  }
}
