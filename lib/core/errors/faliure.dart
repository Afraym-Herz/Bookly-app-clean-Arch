import 'package:dio/dio.dart';

abstract class Faliure {
  final String errMessage;
  Faliure({required this.errMessage});
}

class ServerFaliure extends Faliure {
  ServerFaliure({required super.errMessage});

  factory ServerFaliure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFaliure(errMessage: 'connection time out with Api server');

      case DioExceptionType.sendTimeout:
        return ServerFaliure(errMessage: 'There was send timeout');

      case DioExceptionType.receiveTimeout:
        return ServerFaliure(
            errMessage: 'There was receive timeout with Api server');

      case DioExceptionType.badCertificate:
        return ServerFaliure(
            errMessage: 'There was badCertificate with Api server');

      case DioExceptionType.badResponse:
        return ServerFaliure.fromBadResponse(e.response);

      case DioExceptionType.cancel:
        return ServerFaliure(errMessage: 'Request with Api server was canceld');

      case DioExceptionType.connectionError:
        return ServerFaliure(
            errMessage: 'There was connection error with Api server');

      case DioExceptionType.unknown:
        return ServerFaliure(errMessage: 'There was unknown error');
    }
  }

  factory ServerFaliure.fromBadResponse(dynamic response) {
    if (response.statusCode == 404) {
      return ServerFaliure(
          errMessage: "Your request is not found , please try again");
    } else if (response.statusCode == 500) {
      return ServerFaliure(
          errMessage:
              'There is a problem with server , please try again later');
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 403) {
      return ServerFaliure(errMessage: response['error']['message']);
    } else {
      return ServerFaliure(
          errMessage: 'there was an unexpected error , please try again later');
    }
  }
}
