import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'model.dart';

Future<List<Store>> getall() async {
  List<Store> data = [];
  Response response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
  if (response.statusCode == 200) {
    final List<dynamic> datas = jsonDecode(response.body);
    data = datas.map((json) => Store.fromJson(json)).toList();
  }
  return data;
}

Future<dynamic> checkloginstatus(String? user, String? pass) async {
  Response res = await http.post(
      Uri.parse(
        "https://fakestoreapi.com/auth/login",
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "username": user.toString(),
        "password": pass.toString(),
        "id": "3"
      }));
  return res;
}