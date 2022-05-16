import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '../Model/dog.dart';
part 'dog_api_client.g.dart';

@RestApi(baseUrl: "https://api.thedogapi.com/v1")
abstract class DogRestClient {
  factory DogRestClient(Dio dio, {String baseUrl}) = _DogRestClient;

  @GET("/breeds")
  @Headers(<String, dynamic>{
    "x-api-key": "8aa4cbe9-6683-4cbe-892e-b0d4e914f2e7"
  })
  Future<List<Dog>> getDogsBreedInformations(@Query("limit") int limit);
}
