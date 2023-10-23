part of 'detailed_product_cubit.dart';

abstract class DetailedProductState extends Equatable {
  const DetailedProductState();
}

class DetailedProductInitial extends DetailedProductState {
  @override
  List<Object> get props => [];
}

class DetailedProductLoadInProgress extends DetailedProductState {
  @override
  List<Object> get props => [];
}

class DetailedProductLoadSuccess extends DetailedProductState {
  final DetailedProduct detailedProduct;
  const DetailedProductLoadSuccess(this.detailedProduct);
  @override
  List<Object> get props => [detailedProduct];
}

class DetailedProductLoadFailure extends DetailedProductState {
  final String error;
  const DetailedProductLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
