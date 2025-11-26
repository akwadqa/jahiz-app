import 'package:dartz/dartz.dart';
import '../entities/category.dart';
import '../repositories/categories_repository.dart';

import '../../../../core/error/failures.dart';

class GetCategoriesUseCase {
  final CategoriesRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<Either<Failure, Category>> call(String category,String? search) async =>
      await _repository.getCategories(category,search);
}
