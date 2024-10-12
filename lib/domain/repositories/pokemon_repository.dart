import 'package:dartz/dartz.dart';
import 'package:pokemon_card_list/core/errors/failures.dart';
import 'package:pokemon_card_list/data/models/pokemon_card.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<PokemonCard>>> getPokemonCards(int page);

  Future<Either<Failure, List<PokemonCard>>> searchPokemonCards(
      String query, int page);
}
