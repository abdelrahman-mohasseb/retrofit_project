// ******************************************************************************
// Api response model data to handle error and success cases from a network call
// *******************************************************************************

class ApiResponse {
  /// variable holding the status of the apiRequest at [ApiResponseType]

  final ApiResponseType apiStatus;

  /// variable holding the result of the apiRequest

  final dynamic result;

  /// variable holding the message in case of error of the apiRequest,
  ///  it can be null in case of a success call

  final String? errorMessage;

  get message {
    if (errorMessage != null && errorMessage!.isNotEmpty) {
      return errorMessage;
    }
    return apiStatus.message;
  }

  ApiResponse(this.apiStatus, this.result, [this.errorMessage]);

  static ApiResponseType convert(int statusCode) {
    if (statusCode == ApiResponseType.ok.code) {
      return ApiResponseType.ok;
    } else if (statusCode == ApiResponseType.badRequest.code) {
      return ApiResponseType.badRequest;
    } else if (statusCode == ApiResponseType.unauthorized.code) {
      return ApiResponseType.unauthorized;
    } else if (statusCode == ApiResponseType.forbidden.code) {
      return ApiResponseType.forbidden;
    } else if (statusCode == ApiResponseType.notFound.code) {
      return ApiResponseType.notFound;
    } else if (statusCode == ApiResponseType.methodNotAllowed.code) {
      return ApiResponseType.methodNotAllowed;
    } else if (statusCode == ApiResponseType.conflict.code) {
      return ApiResponseType.conflict;
    } else if (statusCode == ApiResponseType.internalServerError.code) {
      return ApiResponseType.internalServerError;
    } else {
      return ApiResponseType.other;
    }
  }
}

/// enum represtening the different types of the api responses in case of success or failure

enum ApiResponseType {
  ok,
  unauthorized,
  badRequest,
  forbidden,
  notFound,
  methodNotAllowed,
  conflict,
  internalServerError,
  other,
}

/// returns the code specified for each ApiResponse Type

extension ApiErrorTypeExtension on ApiResponseType {
  get code {
    switch (this) {
      case ApiResponseType.ok:
        return 200;
      case ApiResponseType.badRequest:
        return 400;
      case ApiResponseType.unauthorized:
        return 401;
      case ApiResponseType.forbidden:
        return 403;
      case ApiResponseType.notFound:
        return 404;
      case ApiResponseType.methodNotAllowed:
        return 405;
      case ApiResponseType.conflict:
        return 409;
      case ApiResponseType.internalServerError:
        return 500;
      default:
        return null;
    }
  }

  /// return the message shown to the user in each case of a failure Api Request

  get message {
    switch (this) {
      case ApiResponseType.ok:
        return "";
      case ApiResponseType.unauthorized:
        return "Unauthorized, please review your credentials";
      case ApiResponseType.badRequest:
        return "Connexion Error";
      case ApiResponseType.forbidden:
        return "Connexion Error , you are not allowed";
      case ApiResponseType.notFound:
        return "Connexion Error due to server not existed";
      case ApiResponseType.methodNotAllowed:
        return "Connexion Error due to permission to server not granted";
      case ApiResponseType.conflict:
        return "Connexion Error due to conflict between the application and the server";
      case ApiResponseType.internalServerError:
        return "Connexion Error due to server。";
      default:
        return "Connexion Error please retry again";
    }
  }
}
