import 'package:bloc/bloc.dart';


class ProductDetailsTabBarIndexCubit extends Cubit<int> {
  ProductDetailsTabBarIndexCubit() : super(0);

  void changeIndex(int index) => emit(index);
}
