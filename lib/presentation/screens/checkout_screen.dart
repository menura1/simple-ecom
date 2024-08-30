import 'package:ecom_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cart = (state as CartSuccess).products;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Checkout"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Shipping details",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      labelText: "Name"),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      labelText: "Phone number"),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    labelText: "Address",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Order summary",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cart[index].name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text("\$${cart[index].price}",
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: MaterialButton(
            onPressed: () {
              Get.snackbar(
                "Order placed!",
                "You will receive your order soon.",
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                margin: EdgeInsets.zero,
                borderRadius: 0,
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
            child: Text("Place order (\$${cart.fold(
              0.0,
              (sum, product) =>
                  sum +
                  double.parse(
                    product.price,
                  ),
            )})"),
          ),
        );
      },
    );
  }
}
