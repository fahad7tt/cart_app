import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'application/cart_bloc/cart_bloc.dart';
import 'application/home_cubit/home_cubit.dart';
import 'application/login_bloc/login_bloc.dart';
import 'application/splash_cubit/splash_cubit.dart';
import 'presentation/screens/splash screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (BuildContext context) => SplashCubit(),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
        ),
        BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}