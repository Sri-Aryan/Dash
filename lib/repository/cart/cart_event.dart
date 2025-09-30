
part of 'cart_bloc.dart';

@immutable
sealed class CartEvent{}

class AddToCartEvent extends CartEvent{
  final String itemName;
  final int price;
  AddToCartEvent(this.itemName,this.price);
}

class RemoveFromCartEvent extends CartEvent{
  final String name;
  RemoveFromCartEvent(this.name);
}

class UpdateQuantityEvent extends CartEvent{
  final String name;
  final int change;
  UpdateQuantityEvent(this.name,this.change);
}

class ClearCartEvent extends CartEvent{}