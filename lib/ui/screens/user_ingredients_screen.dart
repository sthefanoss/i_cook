import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_cook/models/recipe.dart';

class UserIngredientsScreen extends StatefulWidget {
  const UserIngredientsScreen({Key? key}) : super(key: key);

  @override
  _UserIngredientsScreenState createState() => _UserIngredientsScreenState();
}

class _UserIngredientsScreenState extends State<UserIngredientsScreen> {
  late final Recipe favoriteRecipe;
  final quantities = <String, int>{};
  final ingredientsKeys = ingredients.keys.toList();

  @override
  void initState() {
    favoriteRecipe = Get.arguments;
    ingredients.entries.forEach((i) => quantities[i.key] = 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iCook'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Quais ingredientes você possui em casa?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: quantities.length,
              itemBuilder: (context, index) {
                final ingredient = ingredientsKeys[index];
                final quantity = quantities[ingredient]!;
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text(ingredient)),
                      SizedBox(width: 20),
                      IconButton(
                          onPressed: () => setState(
                              () => quantities[ingredient] = quantity + 1),
                          icon: Icon(Icons.add)),
                      Text(quantities[ingredient].toString()),
                      IconButton(
                          onPressed: quantity > 0
                              ? () => setState(
                                  () => quantities[ingredient] = quantity - 1)
                              : null,
                          icon: Icon(Icons.remove)),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {}, child: Text('Confirmar  ')),
          ),
        ],
      ),
    );
  }
}
