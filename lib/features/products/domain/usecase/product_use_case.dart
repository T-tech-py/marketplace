
import 'package:dartz/dartz.dart';
import 'package:marketplace/core/utils/failure.dart';
import 'package:marketplace/core/utils/use_case.dart';
import 'package:marketplace/features/products/domain/entity/product_entity.dart';
import 'package:marketplace/features/products/domain/repository/product_repository.dart';

class ProductUseCase implements UseCase<ProductEntity, int > {
  final ProductRepository _repository;

  ProductUseCase({
    required ProductRepository productRepository,
  }) : _repository = productRepository;

  @override
  Future<Either<Failure, ProductEntity>> call(int params) {
    return _repository.getProduct(params.toString());
  }
}
