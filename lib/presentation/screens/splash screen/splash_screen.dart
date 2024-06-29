import 'package:bloc_sample/application/splash_cubit/splash_cubit.dart';
import 'package:bloc_sample/application/splash_cubit/splash_state.dart';
import 'package:bloc_sample/presentation/screens/home%20screen/home_screen.dart';
import 'package:bloc_sample/presentation/screens/login%20screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is LoadedState) {
            if (state.loginState == null || state.loginState == false) {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (ct) {
                return const LoginPage();
              }));
            } else {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()));
            }
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
