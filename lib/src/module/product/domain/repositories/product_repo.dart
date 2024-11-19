import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/entities.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, bool>> addProduct({required ProductEntity product});

  Future<Either<Failure, bool>> addOrder({
    required OrderEntity order,
  });
}
