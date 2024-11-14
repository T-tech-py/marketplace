
import 'package:dartz/dartz.dart';
import 'package:marketplace/core/utils/failure.dart';
import 'package:marketplace/core/utils/use_case.dart';
import 'package:marketplace/features/products/domain/entity/product_entity.dart';
import 'package:marketplace/features/products/domain/repository/product_repository.dart';

class GetProductUseCase implements UseCase<List<ProductEntity>,
    Null > {
  final ProductRepository _repository;

  GetProductUseCase({
    required ProductRepository productRepository,
  }) : _repository = productRepository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(Null params) {
    return _repository.getProducts();
  }
}