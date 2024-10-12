import 'package:dartz/dartz.dart';
import 'package:pokemon_card_list/core/errors/failures.dart';
import 'package:pokemon_card_list/data/models/pokemon_card.dart';
import 'package:pokemon_card_list/domain/repositories/pokemon_repository.dart';

class SearchPokemonCards {
  final PokemonRepository repository;

  SearchPokemonCards(this.repository);

  Future<Either<Failure, List<PokemonCard>>> call(String query,
      {int page = 1}) async {
    return await repository.searchPokemonCards(query, page);
  }
}
