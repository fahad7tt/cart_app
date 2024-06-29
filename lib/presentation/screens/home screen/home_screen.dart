import 'package:bloc_sample/application/cart_bloc/cart_bloc.dart';
import 'package:bloc_sample/application/cart_bloc/cart_event.dart';
import 'package:bloc_sample/application/cart_bloc/cart_state.dart';
import 'package:bloc_sample/application/home_cubit/home_cubit.dart';
import 'package:bloc_sample/application/home_cubit/home_state.dart';
import 'package:bloc_sample/presentation/screens/cart%20screen/cart_screen.dart';
import 'package:bloc_sample/presentation/screens/login%20screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> logout() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final SharedPreferences _shared = await SharedPreferences.getInstance();
    _shared.setBool("Login", false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: 
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        return Stack(
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const CartScreen();
                }));
              },
              child: const Icon(Icons.shopping_cart),
            ),
            Positioned(
                child: CircleAvatar(
                    radius: 10,
                    child: Text(
                        "${BlocProvider.of<CartBloc>(context).cartMap.length}")))
          ],
        );
      }),
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text("Confirm sign out?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              logout();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (ctx) {
                                return const LoginPage();
                              }), (route) => false);
                            },
                            child: const Text("Yes"),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("No"))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Center(child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state is HomeLoadedState
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 8,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 179, 186, 201),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                state.allproducts[index].image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(height: 4),
                                    SizedBox(
                                        width: 140,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        child: Center(
                                            child: Text(
                                          state.allproducts[index].name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ))),
                                    const SizedBox(height: 2),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    BlocBuilder<CartBloc, CartState>(
                                      builder: (context, state1) {
                                        return Material(
                                          elevation: 10,
                                          shape:
                                              const CircleBorder(eccentricity: 1),
                                          color: Colors.transparent,
                                          child: SizedBox(
                                            width: 100,
                                            height: 28,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                BlocProvider.of<CartBloc>(context)
                                                    .add(CartButtonEvent(
                                                        product: state
                                                            .allproducts[index]));
                                                // Display Snackbar
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        '${state.allproducts[index].name} added to cart'),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "Add to Cart",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: state.allproducts.length,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        )),
      ),
    );
  }
}
