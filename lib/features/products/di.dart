import 'package:get_it/get_it.dart';
import 'package:marketplace/core/services/network_service.dart';
import 'package:marketplace/features/products/data/repositories/product_repository_impl.dart';
import 'package:marketplace/features/products/domain/repository/product_repository.dart';
import 'package:marketplace/features/products/domain/usecase/get_categories_use_case.dart';
import 'package:marketplace/features/products/domain/usecase/get_product_use_case.dart';
import 'package:marketplace/features/products/domain/usecase/product_use_case.dart';
import 'package:marketplace/features/products/presentation/manager/product_riverpod.dart';

GetIt sl = GetIt.instance;



Future<void> productDependencies() async {

  sl..registerLazySingleton<ProductRiverPod>(() =>
      ProductRiverPod( sl<GetProductUseCase>(), sl<GetCategoryUseCase>(),
          sl<ProductUseCase>())
  )..registerLazySingleton<GetProductUseCase>(()=>
      GetProductUseCase(productRepository: sl<ProductRepository>()))
    ..registerLazySingleton<GetCategoryUseCase>(()=>
        GetCategoryUseCase(productRepository: sl<ProductRepository>()))
    ..registerLazySingleton<ProductUseCase>(()=>
        ProductUseCase(productRepository: sl<ProductRepository>()))
    ..registerLazySingleton<ProductRepository>(()=>
        ProductRepositoryImpl(sl<NetworkApiService>()));

}