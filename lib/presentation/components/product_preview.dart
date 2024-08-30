import 'package:ecom_app/data/models/product.dart';
import 'package:ecom_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecom_app/presentation/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPreview extends StatefulWidget {
  const ProductPreview(this.product, {super.key});

  final Product product;

  @override
  State<ProductPreview> createState() => _ProductPreviewState();
}

class _ProductPreviewState extends State<ProductPreview> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cart = (state as CartSuccess).products;
        final product = widget.product;
        bool contains = cart.any(
          (e) => e.id == product.id,
        );
        return ListTile(
          title: Text(product.name),
          subtitle: Text("\$ ${product.price}"),
          leading: Hero(
            tag: product.id,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(product.image)),
          ),
          trailing: IconButton(
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
            icon: Icon(
              contains
                  ? Icons.remove_shopping_cart
                  : Icons.add_shopping_cart_rounded,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(product),
              ),
            );
          },
        );
      },
    );
  }
}
