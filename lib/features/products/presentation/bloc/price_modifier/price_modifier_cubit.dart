import 'package:bloc/bloc.dart';
import '../../../domain/entities/price_modifier.dart';

class PriceModifierCubit extends Cubit<PriceModifier> {
  PriceModifierCubit() : super(const PriceModifier(1, 0));

  void incrementQuantity() =>
      emit(state.copyWith(quantity: state.quantity + 1));
  void decrementQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void setAmount(double amount) => emit(state.copyWith(amount: amount));
}
