import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_card_list/data/models/pokemon_card.dart';
import 'package:pokemon_card_list/presentation/pages/pokemon_details_page.dart';
import 'package:pokemon_card_list/presentation/widgets/network_image_widget.dart';

class GridItem extends StatelessWidget {
  final PokemonCard card;

  const GridItem({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PokemonDetailsPage(card: card));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: NetworkImageWidget(
                imageUrl: card.images.large,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                card.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
