part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class LoadedUserProfileState extends ProfileState {
  final UserEntity user;
  const LoadedUserProfileState(this.user);
  @override
  List<Object> get props => [user];
}

class UpdatedUserNameState extends ProfileState {
  final bool isUpdated;
  const UpdatedUserNameState(this.isUpdated);
  @override
  List<Object> get props => [isUpdated];
}

class UpdatedUserPhotoState extends ProfileState {
  final bool isUpdated;
  const UpdatedUserPhotoState(this.isUpdated);
  @override
  List<Object> get props => [isUpdated];
}

class LoadedAllShippingAddressState extends ProfileState {
  final List<ShippingAddressEntity> allShippingAddresses;
  const LoadedAllShippingAddressState(this.allShippingAddresses);
  @override
  List<Object> get props => [allShippingAddresses];
}

class AddedShippingAddressState extends ProfileState {
  final bool isUpdated;
  const AddedShippingAddressState(this.isUpdated);
  @override
  List<Object> get props => [isUpdated];
}

class UpdatedShippingAddressState extends ProfileState {
  final bool isUpdated;
  const UpdatedShippingAddressState(this.isUpdated);
  @override
  List<Object> get props => [isUpdated];
}

class ProfileFailureState extends ProfileState {
  final Failure message;
  const ProfileFailureState(this.message);
  @override
  List<Object> get props => [message];
}
