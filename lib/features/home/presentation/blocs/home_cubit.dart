import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/home_block.dart';
import '../../domain/usecases/get_home_blocks.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHomeBlocksUseCase) : super(HomeInitial()) {
    getHomeBlocks();
  }
  final GetHomeBlocksUseCase _getHomeBlocksUseCase;
  Future<void> getHomeBlocks() async {
    emit(HomeLoadInProgress());
    final failureOrHomeBlocks = await _getHomeBlocksUseCase();
    failureOrHomeBlocks.fold(
        (failure) => emit(HomeLoadFailure(failure.message)),
        (homeBlocks) => homeBlocks.isEmpty
            ? emit(HomeLoadEmpty())
            : emit(HomeLoadSuccess(homeBlocks)));
  }
}
