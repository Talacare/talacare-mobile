import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (err.response?.statusCode == 401) {
      debugPrint('Request Unauthorized: ${err.response?.data}');
      getIt<AuthProvider>().setUser(null);
    }
  }
}
