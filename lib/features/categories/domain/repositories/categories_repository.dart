import 'package:dartz/dartz.dart';
import '../entities/category.dart';

import '../../../../core/error/failures.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, Category>> getCategories(
      String category, String? search);
}
