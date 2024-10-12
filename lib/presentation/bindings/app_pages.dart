import 'package:get/get.dart';
import 'package:pokemon_card_list/presentation/pages/pokemon_details_page.dart';
import 'package:pokemon_card_list/presentation/pages/pokemon_list_page.dart';

class AppPages {
  static const String initialPage = '/list';
  static final pages = [
    GetPage(name: '/list', page: () => PokemonListPage()),
    GetPage(name: '/details', page: () => PokemonDetailsPage(card: Get.arguments)),
  ];
}
