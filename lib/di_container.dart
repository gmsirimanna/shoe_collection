import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:products_list/data/repository/cart_repo.dart';
import 'package:products_list/providers/cart_provider.dart';
import 'data/repository/dio/dio_client.dart';
import 'data/repository/dio/logging_interceptor.dart';
import 'data/repository/products_repo.dart';
import 'providers/products_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => ProductsRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => CartRepo(sharedPreferences: sl()));

  // Provider
  sl.registerFactory(() => ProductsProvider(productsRepo: sl()));
  sl.registerFactory(() => CartProvider(cartRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
