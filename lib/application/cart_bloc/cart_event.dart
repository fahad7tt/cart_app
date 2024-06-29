import 'package:bloc_sample/domain/model.dart';

abstract class CartEvent {}

class CartInitial extends CartEvent {}

class CartButtonEvent extends CartEvent {
  Store product;
  CartButtonEvent({required this.product});
}

class CartAddEvent extends CartEvent {
  Store product;
  CartAddEvent({required this.product});
}

class CartSubEvent extends CartEvent {
  Store product;
  CartSubEvent({required this.product});
}

class CartItemRemovedevent extends CartEvent {}