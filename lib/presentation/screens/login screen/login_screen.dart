import 'package:bloc_sample/application/login_bloc/login_bloc.dart';
import 'package:bloc_sample/application/login_bloc/login_event.dart';
import 'package:bloc_sample/application/login_bloc/login_state.dart';
import 'package:bloc_sample/presentation/screens/home%20screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _user = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _pass = TextEditingController();
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _user,
              decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _pass,
              decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  sharedlogin();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "Success",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return const HomeScreen();
                  }));
                } else if (state is LoginErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "invalid username or password",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              builder: (context, state) {
                return Material(
                  elevation: 10,
                  shape: const CircleBorder(eccentricity: 1),
                  color: Colors.transparent,
                  child: state is LoginCheckingState
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LoginChecking(
                              user: _user.text,
                              pass: _pass.text,
                            ));
                          },
                          child: const Text("Login"),
                        ),
                );
              },
            )
          ],
        ),
      )),
    );
  }

  Future<void> sharedlogin() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final SharedPreferences _shared = await SharedPreferences.getInstance();
    _shared.setBool("Login", true);
  }
}