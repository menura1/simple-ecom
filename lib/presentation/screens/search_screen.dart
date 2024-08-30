import 'package:ecom_app/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:ecom_app/presentation/components/product_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeScreenBloc>(context).add(HomeScreenFilter(""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeScreenBloc>(context);
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              autofocus: true,
              decoration: const InputDecoration(hintText: "Search"),
              onChanged: (value) {
                bloc.add(HomeScreenFilter(value));
              },
            ),
          ),
          body: state is HomeScreenSuccess
              ? ListView.separated(
                  padding: const EdgeInsets.only(top: 5),
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) =>
                      ProductPreview(state.filteredProducts[index]),
                  itemCount: state.filteredProducts.length,
                )
              : const Text("Error"),
        );
      },
    );
  }
}
