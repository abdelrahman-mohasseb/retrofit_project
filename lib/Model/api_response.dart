class ApiResponse {

  final ApiResponseType apiStatus;
  final dynamic result;
  final String? errorMessage;

  get message {
     if (errorMessage != null && errorMessage!.isNotEmpty) {
       return errorMessage;
     }
    return this.apiStatus.message;
  }

  ApiResponse(this.apiStatus, this.result, [this.errorMessage]);

  static ApiResponseType convert(int statusCode) {
    if (statusCode == ApiResponseType.OK.code) {
      return ApiResponseType.OK;
    } else if (statusCode == ApiResponseType.BadRequest.code) {
      return ApiResponseType.BadRequest;
    } else if (statusCode == ApiResponseType.Forbidden.code) {
      return ApiResponseType.Forbidden;
    } else if (statusCode == ApiResponseType.NotFound.code) {
      return ApiResponseType.NotFound;
    } else if (statusCode == ApiResponseType.MethodNotAllowed.code) {
      return ApiResponseType.MethodNotAllowed;
    } else if (statusCode == ApiResponseType.Conflict.code) {
      return ApiResponseType.Conflict;
    } else if (statusCode == ApiResponseType.InternalServerError.code) {
      return ApiResponseType.InternalServerError;
    } else {
      return ApiResponseType.other;
    }
  }

}

enum ApiResponseType {
  OK,
  BadRequest,
  Forbidden,
  NotFound,
  MethodNotAllowed,
  Conflict,
  InternalServerError,
  other,
}

extension ApiErrorTypeExtension on ApiResponseType {

  get code {
    switch (this) {
      case ApiResponseType.OK:
        return 200;
      case ApiResponseType.BadRequest:
        return 400;
      case ApiResponseType.Forbidden:
        return 403;
      case ApiResponseType.NotFound:
        return 404;
      case ApiResponseType.MethodNotAllowed:
        return 405;
      case ApiResponseType.Conflict:
        return 409;
      case ApiResponseType.InternalServerError:
        return 500;
      default:
        return null;
    }
  }

  get message {
    switch (this) {
      case ApiResponseType.OK:
        return "";
      case ApiResponseType.BadRequest:
        return "Connexion Error";
      case ApiResponseType.Forbidden:
        return "Connexion Error , you are not allowed";
      case ApiResponseType.NotFound:
        return "Connexion Error due to server not existed";
      case ApiResponseType.MethodNotAllowed:
        return "Connexion Error due to permission to server not granted";
      case ApiResponseType.Conflict:
        return "Connexion Error due to conflict between the application and the server";
      case ApiResponseType.InternalServerError:
        return "Connexion Error due to server。";
      default:
        return "Connexion Error please retry again";
    }
  }
}