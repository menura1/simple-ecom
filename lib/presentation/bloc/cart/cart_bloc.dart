import 'package:bloc/bloc.dart';
import 'package:ecom_app/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartSuccess()) {
    on<CartAdd>((event, emit) {
      if (state is CartSuccess) {
        final prev = (state as CartSuccess).products;
        emit(
          CartSuccess(
            products: [...prev, event.product],
          ),
        );
        Get.snackbar(
          "Added to cart!",
          event.product.name,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: EdgeInsets.zero,
          borderRadius: 0,
        );
      }
    });

    on<CartRemove>((event, emit) {
      if (state is CartSuccess) {
        final prev = (state as CartSuccess).products;
        prev.removeWhere(
          (e) => e.id == event.id,
        );
        emit(
          CartSuccess(
            products: prev,
          ),
        );
        Get.snackbar(
          "Removed from cart!",
          "This item has been removed from your cart.",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: EdgeInsets.zero,
          borderRadius: 0,
        );
      }
    });
  }
}
