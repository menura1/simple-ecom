part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

final class HomeScreenLoading extends HomeScreenState {}

final class HomeScreenSuccess extends HomeScreenState {
  HomeScreenSuccess(this.products,this.filteredProducts);

  final List<Product> products;
  final List<Product> filteredProducts;
}

final class HomeScreenError extends HomeScreenState {
  final String error;

  HomeScreenError(this.error);
}
