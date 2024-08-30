import 'package:ecom_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecom_app/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:ecom_app/presentation/components/product_preview.dart';
import 'package:ecom_app/presentation/screens/cart_screen.dart';
import 'package:ecom_app/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeScreenBloc>(context).add(HomeScreenFetchData());
    print((BlocProvider.of<CartBloc>(context).state as CartSuccess).products);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Products"),
            actions: [
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.shopping_cart),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        (context.watch<CartBloc>().state as CartSuccess)
                            .products
                            .length
                            .toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: state is HomeScreenSuccess
              ? ListView.separated(
                  padding: const EdgeInsets.only(top: 5),
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) =>
                      ProductPreview(state.products[index]),
                  itemCount: state.products.length,
                )
              : state is HomeScreenLoading || state is HomeScreenInitial
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Center(
                      child: Text("Error!"),
                    ),
        );
      },
    );
  }
}
