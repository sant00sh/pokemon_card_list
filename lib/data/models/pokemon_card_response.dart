import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokemon_card_list/data/models/pokemon_card.dart';

part 'pokemon_card_response.freezed.dart';
part 'pokemon_card_response.g.dart';

@freezed
class PokemonCardResponse with _$PokemonCardResponse {
  const factory PokemonCardResponse({
    required List<PokemonCard> data,
    required int page,
    required int pageSize,
    required int count,
    required int totalCount,
  }) = _PokemonCardResponse;

  factory PokemonCardResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonCardResponseFromJson(json);
}
