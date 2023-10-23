import 'package:dartz/dartz.dart';
import 'package:jahiz/features/products/domain/entities/detailed_product.dart';
import 'package:jahiz/features/products/domain/repositories/products_repository.dart';

import '../../../../core/error/failures.dart';

class GetDetailedProductUseCase {
  final ProductsRepository _repository;

  GetDetailedProductUseCase(this._repository);

  Future<Either<Failure, DetailedProduct>> call(String productId) async =>
      await _repository.getDetailedProduct(productId);
}
