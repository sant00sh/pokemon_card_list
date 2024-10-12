import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_card.freezed.dart';
part 'pokemon_card.g.dart';

@freezed
class PokemonCard with _$PokemonCard {
  const factory PokemonCard({
    required String id,
    required String name,
    required Images images,
    required String supertype,
    @Default([]) List<String> types,
    @Default([]) List<Attack> attacks,
    @Default([]) List<Weakness> weaknesses,
    required String artist,
    required Set set,
  }) = _PokemonCard;

  factory PokemonCard.fromJson(Map<String, dynamic> json) =>
      _$PokemonCardFromJson(json);
}

@freezed
class Images with _$Images {
  const factory Images({
    required String small,
    required String large,
  }) = _Images;

  factory Images.fromJson(Map<String, dynamic> json) =>
      _$ImagesFromJson(json);
}

@freezed
class Attack with _$Attack {
  const factory Attack({
    required String name,
    @Default([]) List<String> cost,
    int? convertedEnergyCost,
    @Default('') String damage,
    @Default('') String text,
  }) = _Attack;

  factory Attack.fromJson(Map<String, dynamic> json) =>
      _$AttackFromJson(json);
}

@freezed
class Weakness with _$Weakness {
  const factory Weakness({
    required String type,
    required String value,
  }) = _Weakness;

  factory Weakness.fromJson(Map<String, dynamic> json) =>
      _$WeaknessFromJson(json);
}

@freezed
class Set with _$Set {
  const factory Set({
    required String id,
    required String name,
    required String series,
    required int printedTotal,
    required int total,
    required String releaseDate,
  }) = _Set;

  factory Set.fromJson(Map<String, dynamic> json) =>
      _$SetFromJson(json);
}