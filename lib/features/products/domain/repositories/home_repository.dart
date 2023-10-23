import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/failures.dart';

import '../entities/home_block.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeBlock>>> getHomeBlocks();
}
