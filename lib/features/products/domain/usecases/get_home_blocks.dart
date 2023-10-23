import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/products/domain/repositories/home_repository.dart';

import '../entities/home_block.dart';

class GetHomeBlocksUseCase {
  final HomeRepository _repository;

  GetHomeBlocksUseCase(this._repository);

  Future<Either<Failure, List<HomeBlock>>> call() async =>
      await _repository.getHomeBlocks();
}
