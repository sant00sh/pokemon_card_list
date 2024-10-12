import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pokemon_card_list/data/datasources/pokemon_api_service.dart';
import 'package:pokemon_card_list/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_card_list/domain/usecases/get_pokemon_cards.dart';
import 'package:pokemon_card_list/domain/usecases/search_pokemon_cards.dart';

import 'core/network/dio_helper.dart';

void init() {
  // Dio
  Get.lazyPut(() => DioHelper(Dio()));

  // API Service
  Get.lazyPut(() => PokemonApiService(Get.find<DioHelper>().dio));

  // Repository
  Get.lazyPut(() => PokemonRepositoryImpl(Get.find<PokemonApiService>()));

  // Use cases
  Get.lazyPut(() => GetPokemonCards(Get.find<PokemonRepositoryImpl>()));
  Get.lazyPut(() => SearchPokemonCards(Get.find<PokemonRepositoryImpl>()));
}