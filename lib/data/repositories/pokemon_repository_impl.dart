import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pokemon_card_list/core/env/env.dart';
import 'package:pokemon_card_list/core/errors/failures.dart';
import 'package:pokemon_card_list/data/datasources/pokemon_api_service.dart';
import 'package:pokemon_card_list/data/models/pokemon_card.dart';
import 'package:pokemon_card_list/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApiService apiService;

  PokemonRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<PokemonCard>>> getPokemonCards(int page) async {
    try {
      final response = await apiService.getPokemonCards(
        page: page,
        apiKey: Env.apiKey,
      );
      return Right(response.data.data);
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PokemonCard>>> searchPokemonCards(
      String query, int page) async {
    try {
      final response = await apiService.searchPokemonCards(
        searchQuery: 'name:$query*',
        apiKey: Env.apiKey,
      );
      return Right(response.data.data);
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      if (e.response!.data is Map && e.response!.data['error'] != null) {
        return e.response!.data['error']['message'] ?? 'Unknown server error';
      }
      return 'Server error: ${e.response!.statusCode}';
    }
    return e.message ?? 'Unknown error occurred';
  }
}
