part of 'order_bloc.dart';

abstract class AddressOrderState extends Equatable {
  const AddressOrderState();

  @override
  List<Object> get props => <Object>[];
}

class OrderInitial extends AddressOrderState {}

class OrderLoading extends AddressOrderState {}

class OrderSuccess extends AddressOrderState {
  final List<Address> addresses;

  const OrderSuccess({required this.addresses});

  OrderSuccess copyWith({
    List<Address>? addresses,
  }) {
    return OrderSuccess(
      addresses: addresses ?? this.addresses,
    );
  }
}

final class OrderError extends AddressOrderState {
  final String message;

  const OrderError({required this.message});
}
