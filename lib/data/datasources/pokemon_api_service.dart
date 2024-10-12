import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:pokemon_card_list/data/models/pokemon_card_response.dart';
import 'package:pokemon_card_list/core/utils/constants.dart';

part 'pokemon_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class PokemonApiService {
  factory PokemonApiService(Dio dio, {String baseUrl}) = _PokemonApiService;

  @GET(ApiConstants.cards)
  Future<HttpResponse<PokemonCardResponse>> getPokemonCards({
    @Query("page") int page = 1,
    @Query("pageSize") int pageSize = 10,
    @Header("X-Api-Key") required String apiKey,
  });

  @GET(ApiConstants.cards)
  Future<HttpResponse<PokemonCardResponse>> searchPokemonCards({
    @Query("q") required String searchQuery,
    @Query("page") int page = 1,
    @Query("pageSize") int pageSize = 10,
    @Header("X-Api-Key") required String apiKey,
  });
}