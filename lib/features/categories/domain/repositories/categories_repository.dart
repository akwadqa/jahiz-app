import 'package:dartz/dartz.dart';
import 'package:jahiz/features/categories/domain/entities/category.dart';

import '../../../../core/error/failures.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, Category>> getCategories(String category);
}
