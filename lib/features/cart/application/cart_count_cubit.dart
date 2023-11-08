import 'package:bloc/bloc.dart';
import '../presentation/bloc/cart_cubit.dart';

import 'dart:async';

class CartCountCubit extends Cubit<int> {
  final CartCubit cartCubit;
  StreamSubscription? _cartSubscription;

  CartCountCubit(this.cartCubit) : super(0);

  void init() {
    _cartSubscription = cartCubit.stream.listen((state) {
      if (state is CartLoaded) {
        emit(state.cart.totalQty.toInt());
      } else {
        emit(0);
      }
    });
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
