part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadInProgress extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadSuccess extends SearchState {
  final Category category;
  const SearchLoadSuccess(this.category);
  @override
  List<Object> get props => [category];
}

class SearchLoadEmpty extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadFailure extends SearchState {
  final String error;
  const SearchLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
