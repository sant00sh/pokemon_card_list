import 'package:get/get.dart';
import 'package:pokemon_card_list/data/models/pokemon_card.dart';
import 'package:pokemon_card_list/domain/usecases/get_pokemon_cards.dart';
import 'package:pokemon_card_list/domain/usecases/search_pokemon_cards.dart';

class PokemonController extends GetxController {
  final GetPokemonCards getPokemonCards;
  final SearchPokemonCards searchPokemonCards;

  var isLoading = false.obs;
  var isSearching = false.obs;
  var page = 1.obs;
  var pokemonCards = <PokemonCard>[].obs;
  var searchQuery = ''.obs;
  var hasMore = true.obs;

  PokemonController({
    required this.getPokemonCards,
    required this.searchPokemonCards,
  });

  @override
  void onInit() {
    super.onInit();
    fetchPokemonCards();
  }

  Future<void> fetchPokemonCards({bool loadMore = false}) async {
    if (isLoading.value || (!loadMore && !hasMore.value)) return;

    isLoading(true);
    final result = await getPokemonCards(page.value);
    result.fold(
          (failure) {
        Get.snackbar('Error', failure.message);
      },
          (cards) {
        if (cards.isEmpty) {
          hasMore(false);
        } else {
          if (loadMore) {
            pokemonCards.addAll(cards);
          } else {
            pokemonCards.assignAll(cards);
          }
          page.value++;
        }
      },
    );
    isLoading(false);
  }

  Future<void> searchPokemon(String query, {bool loadMore = false}) async {
    if (query.isEmpty) {
      resetSearch();
      return;
    }

    if (!loadMore) {
      searchQuery(query);
      isSearching(true);
      pokemonCards.clear();
      hasMore(true);
      page(1);
    }

    isLoading(true);
    final result = await searchPokemonCards(query, page: page.value);
    result.fold(
          (failure) {
        Get.snackbar('Error', failure.message);
      },
          (cards) {
        if (cards.isEmpty) {
          hasMore(false);
          if (!loadMore) {
            Get.snackbar('No Results', 'No cards found for "$query"');
          }
        } else {
          if (loadMore) {
            pokemonCards.addAll(cards);
          } else {
            pokemonCards.assignAll(cards);
          }
          page.value++;
        }
      },
    );

    isLoading(false);
  }

  void resetSearch() {
    searchQuery('');
    isSearching(false);
    page(1);
    pokemonCards.clear();
    hasMore(true);
    fetchPokemonCards();
  }

  void loadMore() {
    if (isSearching.value) {
      searchPokemon(searchQuery.value, loadMore: true);
    } else {
      fetchPokemonCards(loadMore: true);
    }
  }
}