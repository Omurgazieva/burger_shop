part of 'payment_methods_cubit.dart';

sealed class PaymentMethodsState extends Equatable {
  const PaymentMethodsState();

  @override
  List<Object> get props => [];
}

final class PaymentMethodsInitial extends PaymentMethodsState {}

class LoadingPaymentMethodsState extends PaymentMethodsState {}

class LoadedAllPaymentCardsState extends PaymentMethodsState {
  final List<PaymentCardEntity> paymentCards;
  const LoadedAllPaymentCardsState(this.paymentCards);
  @override
  List<Object> get props => [paymentCards];
}

class AddedPaymentCardState extends PaymentMethodsState {
  final bool isAdded;
  const AddedPaymentCardState(this.isAdded);
  @override
  List<Object> get props => [isAdded];
}

class UpdatedPaymentCardState extends PaymentMethodsState {
  final bool isUpdated;
  const UpdatedPaymentCardState(this.isUpdated);
  @override
  List<Object> get props => [isUpdated];
}

class SelectedPaymentCardState extends PaymentMethodsState {
  final bool isSelected;
  const SelectedPaymentCardState(this.isSelected);
  @override
  List<Object> get props => [isSelected];
}

class PaymentCardFailureState extends PaymentMethodsState {
  final ServerFailure message;
  const PaymentCardFailureState(this.message);
  @override
  List<Object> get props => [message];
}
