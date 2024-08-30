part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {
  final List<Product> products = const [];
}

final class CartSuccess extends CartState {
  final List<Product> products;

  CartSuccess({this.products = const []});
}

final class CartError extends CartState {}
