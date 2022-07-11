import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import '../model/login.dart';
part 'login_api_client.g.dart';

// *******************************
// Api client for the login api
// *******************************


/// specifies the baseUrl used at [baseUrl]

@RestApi(baseUrl: "http://restapi.adequateshop.com/api/authaccount")
abstract class LoginRestClient {
  factory LoginRestClient(Dio dio, {String baseUrl}) = _LoginRestClient;

  /// sepcifies the type of the network request with annotation [@POST]
  /// and specifies the headers needed like the apiToken with annotation [@Headers]
  
  @POST("/registration")
  Future<String> register(@Body() Login login);

  @POST("/login")
  Future<String> signIn(@Body() Login login);
  
}

