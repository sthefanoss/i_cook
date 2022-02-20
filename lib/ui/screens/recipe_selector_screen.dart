import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/recipe.dart';

class RecipeSelectorScreen extends StatefulWidget {
  const RecipeSelectorScreen({Key? key}) : super(key: key);

  @override
  _RecipeSelectorScreenState createState() => _RecipeSelectorScreenState();
}

class _RecipeSelectorScreenState extends State<RecipeSelectorScreen> {
  final _serchTextEditingController = TextEditingController();
  late final List<ScoredRecipe> _suggestions;
  late final Map<String, int> _userQuantities;

  @override
  void initState() {
    _suggestions = Get.arguments[1];
    _userQuantities = Get.arguments[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                top: 20,
                right: 50,
                bottom: 20,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _serchTextEditingController,
                          decoration: InputDecoration.collapsed(
                              hintText: 'O que você quer comer ?'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26, bottom: 16),
              child: Text(
                'iCook',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            // SizedBox(
            //   height: 50,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: _foodTypes.length,
            //     itemBuilder: (context, index) {
            //       String type = _foodTypes.toList()[index];
            //       bool isSelected = _selectedFoodTypes.contains(type);

            //       return Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 5),
            //         child: Chip(
            //           label: Text(type),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final recipe = _suggestions[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed('/shop',
                        arguments: [recipe, _userQuantities]),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.network(
                            'https://img.itdg.com.br/tdg/images/recipes/000/031/593/318825/318825_original.jpg?mode=crop&width=710&height=400',
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      recipe.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF333333),
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      recipe.name,
                                      style: TextStyle(
                                        color: Color(0xFF707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Chip(label: Text(recipe.score.toString())),
                              SizedBox(width: 18),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(height: 1),
                          Text(
                            'Left over food and supplies are gathered and sold for 50% off!',
                            style: TextStyle(
                              color: Color(0xFFa7a7a7),
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
