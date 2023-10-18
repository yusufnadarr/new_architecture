import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/network_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => NetworkService(Dio())..init());
}
