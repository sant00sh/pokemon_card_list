import 'package:dartz/dartz.dart';
import 'package:pokemon_card_list/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
