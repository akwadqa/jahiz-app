part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadInProgress extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadSuccess extends HomeState {
  final List<HomeBlock> homeBlocks;
  const HomeLoadSuccess(this.homeBlocks);
  @override
  List<Object> get props => [homeBlocks];
}

class HomeLoadEmpty extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadFailure extends HomeState {
  final String error;
  const HomeLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
