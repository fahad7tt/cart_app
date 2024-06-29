import 'package:bloc_sample/domain/model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<Store> allproducts = [];
  HomeLoadedState({required this.allproducts});
}