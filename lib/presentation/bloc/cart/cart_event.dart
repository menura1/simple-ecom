part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartAdd extends CartEvent {
  final Product product;

  CartAdd(this.product);
}

class CartRemove extends CartEvent {
  final String id;

  CartRemove(this.id);
}

class CartEmpty extends CartEvent {}
