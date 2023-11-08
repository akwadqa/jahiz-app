import 'package:dartz/dartz.dart';
import '../../../products/domain/entities/detailed_product.dart';
import '../../../../core/error/failures.dart';

abstract class ProductsRepository {
  Future<Either<Failure, DetailedProduct>> getDetailedProduct(String productId);
}
