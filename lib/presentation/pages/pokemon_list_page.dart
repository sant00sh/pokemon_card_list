import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_card_list/core/utils/constants.dart';
import 'package:pokemon_card_list/presentation/controllers/pokemon_controller.dart';
import 'package:pokemon_card_list/presentation/widgets/grid_item.dart';
import 'package:pokemon_card_list/presentation/widgets/loading_indicator.dart';

class PokemonListPage extends StatelessWidget {
  final PokemonController controller = Get.put(PokemonController(
    getPokemonCards: Get.find(),
    searchPokemonCards: Get.find(),
  ));

  PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Obx(() {
        if (controller.isLoading.value && controller.pokemonCards.isEmpty) {
          return const LoadingIndicator();
        }

        if (controller.pokemonCards.isEmpty) {
          return const Center(child: Text(AppConstants.noCards));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoading.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              controller.loadMore();
            }
            return true;
          },
          child: _gridView(),
        );
      }),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) => AppBar(
        title: const Text(AppConstants.appName),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _searchField(context),
        ),
      );

  Widget _searchField(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextField(
          onChanged: (value) => controller.searchPokemon(value),
          decoration: InputDecoration(
            hintText: AppConstants.searchHint,
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: Visibility(
              visible: controller.searchQuery.value.isNotEmpty,
              child: IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  controller.resetSearch();
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      );

  Widget _gridView() => GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: controller.pokemonCards.length +
            (controller.isLoading.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.pokemonCards.length) {
            return const LoadingIndicator();
          }
          return GridItem(card: controller.pokemonCards[index]);
        },
      );
}
