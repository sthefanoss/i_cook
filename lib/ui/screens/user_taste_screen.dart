import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_cook/data/repository.dart';

import '../../models/recipe.dart';

class UserTasteScreen extends StatefulWidget {
  const UserTasteScreen({Key? key}) : super(key: key);

  @override
  _UserTasteScreenState createState() => _UserTasteScreenState();
}

class _UserTasteScreenState extends State<UserTasteScreen> {
  late final List<Recipe> options;
  late final List<bool> isFavorite;
  final int length = 6;

  @override
  void initState() {
    options = RepositoryImpl().getRecipies(length);
    isFavorite = List.filled(length, false);

    super.initState();
  }

  void toNextScreen() {
    final favoriteState = <String, bool>{};
    for (int i = 0; i < length; i++) {
      favoriteState[options[i].name] = isFavorite[i];
    }
    Get.toNamed('/ingredients', arguments: favoriteState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('iCook')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Por favor, escolha a receita que você mais gosta:',
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
              itemCount: options.length,
              itemBuilder: (context, index) {
                final recipe = options[index];
                return ListTile(
                  title: Text(recipe.name),
                  selected: isFavorite[index],
                  onTap: () {
                    setState(() {
                      isFavorite[index] = !isFavorite[index];
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: toNextScreen, child: Text('Confirmar')),
          ),
        ],
      ),
    );
  }
}
