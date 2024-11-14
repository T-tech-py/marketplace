

import 'package:dartz/dartz.dart';
import 'package:marketplace/core/utils/failure.dart';
import 'package:marketplace/features/products/domain/entity/product_entity.dart';

abstract class ProductRepository{

  Future<Either<Failure, List<Category>>> getCategory();
  Future<Either<Failure,  List<ProductEntity>>> getProducts();
  Future<Either<Failure,  ProductEntity>> getProduct(String id);
}