import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/update_device_token.dart';

part 'update_device_token_state.dart';

class UpdateDeviceTokenCubit extends Cubit<UpdateDeviceTokenState> {
  UpdateDeviceTokenCubit(this._updateDeviceTokenUseCase)
      : super(UpdateDeviceTokenInitial());

  final UpdateDeviceTokenUseCase _updateDeviceTokenUseCase;

  Future<void> updateDeviceToken(
    String deviceToken,
  ) async {
    emit(UpdateDeviceTokenLoading());
    final result = await _updateDeviceTokenUseCase(
      deviceToken: deviceToken,
    );
    result.fold(
      (failure) => emit(UpdateDeviceTokenFailure(failure.message)),
      (response) => emit(UpdateDeviceTokenSuccess()),
    );
  }
}
