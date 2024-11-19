import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetAllProducts {
  final ProductRepo productRepo;
  GetAllProducts(this.productRepo);

  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    return await productRepo.getAllProducts();
  }
}
