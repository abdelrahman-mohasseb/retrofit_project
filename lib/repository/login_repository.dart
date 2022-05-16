import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit_project/ApiClients/login_api_client.dart';
import 'package:retrofit_project/Model/api_response.dart';
import 'package:retrofit_project/Model/login.dart';

class LoginRepository {
  final LoginRestClient _client;

  LoginRepository() : _client = LoginRestClient(Dio());

  Future<ApiResponse> register(Login login) async {
    return await _client
        .register(login)
        .then((value) =>
            ApiResponse(ApiResponseType.OK, jsonDecode(value)["message"]))
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

  Future<ApiResponse> signIn(Login login) async {
    return await _client
        .signIn(login)
        .then((value) =>
            ApiResponse(ApiResponseType.OK, jsonDecode(value)["message"]))
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
