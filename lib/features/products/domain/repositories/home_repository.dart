import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../../../home/domain/entities/home_block.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeBlock>>> getHomeBlocks();
}
