import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketplace/core/services/network_service.dart';
import 'package:marketplace/core/utils/failure.dart';
import 'package:marketplace/features/products/domain/entity/product_entity.dart';
import 'package:marketplace/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository{
  final NetworkApiService _networkApiService;
  ProductRepositoryImpl(this._networkApiService);
  @override
  Future<Either<Failure, List<Category>>> getCategory() async{
    try{
      final data = await _networkApiService.getCategories();
      return Right(data);
    }on DioException catch(e){
      return const Left(ServerFailure(
        message:  'Unknown Error occurred',
        statusCode:  500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async{
    try{
      final data = await _networkApiService.getProducts();

      return Right(data);

    }on DioException catch(e){
      return const Left(ServerFailure(
        message:  'Unknown Error occurred',
        statusCode:  500,
      ));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProduct(String id)async {
    try{
      final data = await _networkApiService.getProduct(id);

      return Right(data);

    }on DioException catch(e){
      return const Left(ServerFailure(
        message:  'Unknown Error occurred',
        statusCode:  500,
      ));
    }
  }
}