import 'package:dartz/dartz.dart';
import 'package:pokemon_card_list/core/errors/failures.dart';
import 'package:pokemon_card_list/data/models/pokemon_card.dart';
import 'package:pokemon_card_list/domain/repositories/pokemon_repository.dart';

class GetPokemonCards {
  final PokemonRepository repository;

  GetPokemonCards(this.repository);

  Future<Either<Failure, List<PokemonCard>>> call(int page) {
    return repository.getPokemonCards(page);
  }
}
