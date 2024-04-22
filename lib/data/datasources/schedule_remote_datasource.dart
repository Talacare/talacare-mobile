import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';
import 'package:talacare/data/models/schedule_model.dart';

abstract class ScheduleRemoteDatasource {
  Future<void> createSchedule(ScheduleModel scheduleModel);
}

class ScheduleRemoteDatasourceImpl extends ScheduleRemoteDatasource {
  final scheduleAPI = '${dotenv.env['API_URL']!}/schedule';
  Dio dio;
  AuthLocalDatasource localDatasource;

  ScheduleRemoteDatasourceImpl({
    required this.dio,
    required this.localDatasource,
  });

  @override
  Future<void> createSchedule(ScheduleModel scheduleModel) async {
    try {
      final token = await localDatasource.readData('access_token');
      await dio.post(
        scheduleAPI,
        data: {'hour': scheduleModel.hour, 'minute': scheduleModel.minute},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (e) {
      var errorMessage = e.response?.data['responseMessage'];
      throw errorMessage;
    }
  }
}
