import 'package:bloc_sample/application/home_cubit/home_state.dart';
import 'package:bloc_sample/domain/api_service.dart';
import 'package:bloc_sample/domain/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState()) {
    emit(HomeLoadingState());
    fetch();
  }
  Future<void> fetch() async {
    List<Store> products = await getall();
    emit(HomeLoadedState(allproducts: products));
  }
}