import 'package:dartz/dartz.dart';
import '../entities/detailed_product.dart';
import '../../../home/domain/repositories/products_repository.dart';

import '../../../../core/error/failures.dart';

class GetDetailedProductUseCase {
  final ProductsRepository _repository;

  GetDetailedProductUseCase(this._repository);

  Future<Either<Failure, DetailedProduct>> call(String productId) async =>
      await _repository.getDetailedProduct(productId);
}
