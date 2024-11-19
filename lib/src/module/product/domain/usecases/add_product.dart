import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/entities.dart';
import '../repositories/product_repo.dart';

class AddProduct extends UseCase<bool, AddProductParams> {
  final ProductRepo productRepo;
  AddProduct(this.productRepo);

  @override
  Future<Either<Failure, bool>> call(AddProductParams params) async {
    return await productRepo.addProduct(
      product: params.product,
    );
  }
}

class AddProductParams extends Equatable {
  final ProductEntity product;

  const AddProductParams({
    required this.product,
  });

  @override
  List<Object?> get props => [product];
}
