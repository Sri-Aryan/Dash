part of 'cart_bloc.dart';

@immutable
class CartState {
  final Map<String, Map<String, dynamic>> cart;
  final int totalItems;
  final int totalCost;

  const CartState({
    this.cart = const {},
    this.totalItems = 0,
    this.totalCost = 0,
  });

  CartState copyWith({
    Map<String, Map<String, dynamic>>? cart,
    int? totalItems,
    int? totalCost,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      totalItems: totalItems ?? this.totalItems,
      totalCost: totalCost ?? this.totalCost,
    );
  }
}
