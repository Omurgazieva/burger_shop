import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class AddOrder extends UseCase<bool, AddOrderParams> {
  final ProductRepo productRepo;
  AddOrder(this.productRepo);

  @override
  Future<Either<Failure, bool>> call(AddOrderParams params) async {
    return await productRepo.addOrder(order: params.order);
  }
}

class AddOrderParams extends Equatable {
  final OrderEntity order;

  const AddOrderParams({required this.order});

  @override
  List<Object?> get props => [order];
}
