import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../product.dart';

class ProductRepoImpl implements ProductRepo {
  ProductRepoImpl({
    required this.remoteProduct,
  });

  final RemoteProduct remoteProduct;

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final allProducts = await remoteProduct.getAllProducts();
      //final allProducts = FakeData().productList;
      return Right(allProducts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addProduct({
    required ProductEntity product,
  }) async {
    try {
      final productID = await remoteProduct.getProductId();
      final isCreated = await remoteProduct.addProduct(
        product: productToModel(productID, product),
      );
      return Right(isCreated);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addOrder({
    required OrderEntity order,
  }) async {
    try {
      final orderId = await remoteProduct.getOrderId();
      final isCreated = await remoteProduct.addOrder(
        order: orderToModel(orderId, order),
      );
      return Right(isCreated);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
