import 'package:dio/dio.dart';
import 'package:pokemon_card_list/core/utils/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  final Dio _dio;

  DioHelper(this._dio) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5000);
    _dio.options.receiveTimeout = const Duration(seconds: 3000);

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  Dio get dio => _dio;
}
