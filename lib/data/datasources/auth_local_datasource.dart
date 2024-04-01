import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDatasource {
  Future<String?> readData(String key);
  Future<void> storeData(String key, String value);
}

class AuthLocalDatasourceImpl extends AuthLocalDatasource {
  FlutterSecureStorage storage;

  AuthLocalDatasourceImpl({required this.storage});

  @override
  Future<String?> readData(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> storeData(String key, String value) async {
    await storage.write(key: key, value: value);
  }
}
