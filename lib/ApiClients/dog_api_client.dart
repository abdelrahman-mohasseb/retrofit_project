import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit_project/model/dog.dart';
part 'dog_api_client.g.dart';

// *******************************
// Api client for the dog api
// *******************************


/// specifies the baseUrl used at [baseUrl]

@RestApi(baseUrl: "https://api.thedogapi.com/v1")
abstract class DogRestClient {
  factory DogRestClient(Dio dio, {String baseUrl}) = _DogRestClient;

  /// sepcifies the type of the network request with annotation [@GET]
  /// and specifies the headers needed like the apiToken with annotation [@Headers]

  @GET("/breeds")
  @Headers(
      <String, dynamic>{"x-api-key": "8aa4cbe9-6683-4cbe-892e-b0d4e914f2e7"})
  Future<List<Dog>> getDogsBreedInformations();
}
