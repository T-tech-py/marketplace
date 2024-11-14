import 'package:dartz/dartz.dart';
import 'package:marketplace/core/utils/failure.dart';

abstract class UseCase<Type,Params> {
  Future<Either<Failure,Type>> call( Params params);
}
