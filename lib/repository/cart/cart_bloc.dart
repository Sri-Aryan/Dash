import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCartEvent>((event, emit) {
      final updatedCart = Map<String, Map<String, dynamic>>.from(state.cart);

      if (updatedCart.containsKey(event.itemName)) {
        updatedCart[event.itemName]!['quantity']++;
      } else {
        updatedCart[event.itemName] = {
          "name": event.itemName,
          "price": event.price,
          "quantity": 1,
        };
      }

      emit(
        state.copyWith(
          cart: updatedCart,
          totalItems: updatedCart.values.fold(0, (sum, item) => sum! + (item['quantity'] as int)),
          totalCost: updatedCart.values.fold(0, (sum, item) => sum! + ((item['quantity'] as int) * (item['price'] as int))),
        ),
      );
    });

    on<UpdateQuantityEvent>((event, emit) {
      final updatedCart = Map<String, Map<String, dynamic>>.from(state.cart);

      if (updatedCart.containsKey(event.name)) {
        updatedCart[event.name]!['quantity'] += event.change;
        if (updatedCart[event.name]!['quantity'] <= 0) {
          updatedCart.remove(event.name);
        }
      }

      emit(
        state.copyWith(
          cart: updatedCart,
          totalItems: updatedCart.values.fold(0, (sum, item) => sum! + (item['quantity'] as int)),
          totalCost: updatedCart.values.fold(0, (sum, item) => sum! + ((item['quantity'] as int) * (item['price'] as int))),
        ),
      );
    });

    on<ClearCartEvent>((event, emit) {
      emit(const CartState());
    });
  }
}
