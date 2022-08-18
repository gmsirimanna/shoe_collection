// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../util/app_constants.dart';
import '../model/response/base/api_response.dart';
import 'dio/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exception/api_error_handler.dart';

class ProductsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  ProductsRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getAllProducts() async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.PRODUCTS_URL}',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
