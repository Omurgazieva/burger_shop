part of 'shipping_address_cubit.dart';

abstract class ShippingAddressState extends Equatable {
  const ShippingAddressState();

  @override
  List<Object> get props => [];
}

class InitialShippingAddresState extends ShippingAddressState {}

class LoadingShippingAddresState extends ShippingAddressState {}

class LoadedShippingAddressState extends ShippingAddressState {
  final List<ShippingAddressEntity> addressList;
  const LoadedShippingAddressState(this.addressList);
  @override
  List<Object> get props => [addressList];
}

class AddedShippingAddresState extends ShippingAddressState {
  final bool isCreated;
  const AddedShippingAddresState(this.isCreated);
  @override
  List<Object> get props => [isCreated];
}

class UpdatedShippingAddresState extends ShippingAddressState {
  final bool isUpdated;
  const UpdatedShippingAddresState(this.isUpdated);
  @override
  List<Object> get props => [isUpdated];
}

class SelectedDefaultAddressState extends ShippingAddressState {
  final bool isSelected;
  const SelectedDefaultAddressState(this.isSelected);
  @override
  List<Object> get props => [isSelected];
}

class ShippingAddresFailureState extends ShippingAddressState {
  final Failure message;
  const ShippingAddresFailureState(this.message);
  @override
  List<Object> get props => [message];
}
