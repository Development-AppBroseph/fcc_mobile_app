part of 'discount_cubit.dart';

class DiscountState extends Equatable {
  const DiscountState(
    this.count,
    this.discount,
  );
  final int count;
  final int discount;
  @override
  List<Object> get props => <Object>[
        count,
        discount,
      ];
}
