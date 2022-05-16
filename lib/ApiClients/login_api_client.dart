import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit_project/Model/login.dart';
part 'login_api_client.g.dart';




@RestApi(baseUrl: "http://restapi.adequateshop.com/api/authaccount")
abstract class LoginRestClient {
  factory LoginRestClient(Dio dio, {String baseUrl}) = _LoginRestClient;
  
  @POST("/registration")
  Future<String> register(@Body() Login login);

  @POST("/login")
  Future<String> signIn(@Body() Login login);
  
}

