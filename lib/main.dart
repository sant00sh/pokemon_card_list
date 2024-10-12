import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_card_list/core/utils/constants.dart';
import 'package:pokemon_card_list/injection.dart' as di;

import 'presentation/bindings/app_pages.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initialPage,
      getPages: AppPages.pages,
    );
  }
}
