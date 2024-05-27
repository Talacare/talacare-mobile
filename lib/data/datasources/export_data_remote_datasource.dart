import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';

abstract class ExportDataRemoteDatasource {
  Future<void> exportData();
}

class ExportDataRemoteDatasourceImpl extends ExportDataRemoteDatasource {
  final exportDataApi = '${dotenv.env['API_URL']!}/export-data';
  Dio dio;
  AuthLocalDatasource localDatasource;

  ExportDataRemoteDatasourceImpl({
    required this.dio,
    required this.localDatasource,
  });

  @override
  Future<void> exportData() async {
    try {
      final token = await localDatasource.readData('access_token');
      await dio.get(
        exportDataApi,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (e) {
      print(e.response?.data);
      var errorMessage = e.response?.data['responseMessage'];
      throw errorMessage;
    }
  }
}
