import 'package:bloc_sample/application/cart_bloc/cart_event.dart';
import 'package:bloc_sample/application/cart_bloc/cart_state.dart';
import 'package:bloc_sample/domain/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<CartButtonEvent>((event, emit) => emit(CartButtonClicked(
        cart: cartMap,
        product: event.product,
      )));
    on<CartAddEvent>((event, emit) => emit(CartButtonClicked(
          cart: cartMap,
          product: event.product,
        )));
    on<CartSubEvent>((event, emit) {
      emit(CartSubClicked(cart: cartMap, product: event.product));
      if (cartMap[event.product] == 0) {
        cartMap.remove(event.product);
        add(CartItemRemovedevent());
      }
    });
    on<CartItemRemovedevent>((event, emit) => emit(CartItemRemovedState()));
  }
  Map<Store, int> cartMap = {};
}