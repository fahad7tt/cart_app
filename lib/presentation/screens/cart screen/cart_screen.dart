import 'package:bloc_sample/application/cart_bloc/cart_bloc.dart';
import 'package:bloc_sample/application/cart_bloc/cart_event.dart';
import 'package:bloc_sample/application/cart_bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        elevation: 6,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartItemRemovedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("item Removed"),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          var data = context.read<CartBloc>().cartMap;
          return SafeArea(
            child: data.isNotEmpty
                ? Column(
                    children: data.keys.map((element) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            SizedBox(
                                height: 100,
                                width: 130,
                                child: Image.network(element.image)),
                            SizedBox(
                              width: 120,
                              child: Text(
                                element.name,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              onPressed: () {
                                // Store the current element before showing the dialog
                                final productToRemove = element;

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirm Delete"),
                                      content: const Text(
                                          "Are you sure you want to delete this item?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            BlocProvider.of<CartBloc>(context)
                                                .add(
                                              CartSubEvent(
                                                  product: productToRemove),
                                            );
                                          },
                                          child: const Text("Yes"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("No"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    );
                  }).toList())
                : const Center(
                    child: Text("Cart empty"),
                  ),
          );
        },
      ),
    );
  }
}