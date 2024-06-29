import 'package:bloc_sample/domain/model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartButtonClicked extends CartState {
  Map<Store, int> cart;
  Store product;
  CartButtonClicked({
    required this.cart,
    required this.product,
  }) {
    cart[product] = (cart[product] ?? 0) + 1;
  }
}

class CartSubClicked extends CartState {
  Map<Store, int> cart;
  Store product;
  CartSubClicked({
    required this.cart,
    required this.product,
  }) {
    cart[product] = (cart[product] ?? 0) - 1;
  }
}

class CartItemRemovedState extends CartState {}