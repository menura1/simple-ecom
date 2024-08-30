import 'package:ecom_app/data/models/product.dart';
import 'package:ecom_app/data/network/base_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<HomeScreenFetchData>((event, emit) async {
      try {
        final res = await baseApi.get("products");
        List<Product> products =
            res.data.map<Product>((e) => Product.fromJson(e)).toList();
        emit(HomeScreenSuccess(products, products));
      } catch (e) {
        emit(HomeScreenError(e.toString()));
      }
    });

    on<HomeScreenFilter>((event, emit) {
      if (state is HomeScreenSuccess) {
        final products = (state as HomeScreenSuccess).products;

        final searchResults = products
            .where((product) =>
                product.name.toLowerCase().contains(event.text.toLowerCase()))
            .toList();

        emit(HomeScreenSuccess(products, searchResults));
      }
    });
  }
}
