import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_cook/ui/screens/recipe_selector_screen.dart';
import 'package:i_cook/ui/screens/user_ingredients_screen.dart';

import 'ui/screens/shop_screen.dart';
import 'ui/screens/user_taste_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iCook',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => const UserTasteScreen(),
        ),
        GetPage(
          name: '/ingredients',
          page: () => const UserIngredientsScreen(),
        ),
        GetPage(
          name: '/suggestions',
          page: () => const RecipeSelectorScreen(),
        ),
        GetPage(
          name: '/shop',
          page: () => const ShopScreen(),
        ),
      ],
    );
  }
}
