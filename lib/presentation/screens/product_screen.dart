import 'package:ecom_app/data/models/product.dart';
import 'package:ecom_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecom_app/presentation/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen(this.product, {super.key});

  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cart = (state as CartSuccess).products;
        final product = widget.product;
        bool contains = cart.any(
          (e) => e.id == product.id,
        );
        return Scaffold(
          appBar: AppBar(
            title: const Text("Product details"),
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
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: product.id,
                child: Image.network(product.image),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "\$ ${product.price}",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (contains) {
                BlocProvider.of<CartBloc>(context).add(
                  CartRemove(product.id),
                );
              } else {
                BlocProvider.of<CartBloc>(context).add(
                  CartAdd(product),
                );
              }
            },
            child: Icon(contains
                ? Icons.remove_shopping_cart
                : Icons.add_shopping_cart_rounded),
          ),
        );
      },
    );
  }
}
