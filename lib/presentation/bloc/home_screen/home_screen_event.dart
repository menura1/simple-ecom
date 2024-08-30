part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}

class HomeScreenFetchData extends HomeScreenEvent {}

class HomeScreenFilter extends HomeScreenEvent {
  final String text;

  HomeScreenFilter(this.text);
}
