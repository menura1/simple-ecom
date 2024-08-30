import 'package:ecom_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecom_app/presentation/components/product_preview.dart';
import 'package:ecom_app/presentation/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cart = (state as CartSuccess).products;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
          ),
          body: cart.isEmpty
              ? Center(
                  child: Text(
                    "Your cart is empty!",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        "Total \$${cart.fold(
                          0.0,
                          (sum, product) =>
                              sum +
                              double.parse(
                                product.price,
                              ),
                        )}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => ProductPreview(
                          cart[index],
                        ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: cart.length,
                      ),
                    ),
                  ],
                ),
          floatingActionButton: Visibility(
            visible: cart.isNotEmpty,
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckoutScreen(),
                  ),
                );
              },
              color: Colors.blue,
              elevation: 0,
              minWidth: MediaQuery.of(context).size.width - 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  50,
                ),
              ),
              child: const Text("Checkout"),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
