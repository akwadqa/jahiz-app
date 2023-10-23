import 'package:dartz/dartz.dart';
import 'package:jahiz/features/categories/domain/entities/category.dart';
import 'package:jahiz/features/categories/domain/repositories/categories_repository.dart';

import '../../../../core/error/failures.dart';

class GetCategoriesUseCase {
  final CategoriesRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<Either<Failure, Category>> call(String category) async =>
      await _repository.getCategories(category);
}
