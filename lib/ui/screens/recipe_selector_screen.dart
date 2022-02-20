import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repository.dart';
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
  final List<Map<String, int>> _missingIngredients = [];
  final Map<String, dynamic> _marketData = {};

  @override
  void initState() {
    _suggestions = Get.arguments[1];
    _userQuantities = Get.arguments[0];
    _getMissingIngridients();
    super.initState();
  }

  void _getMissingIngridients() {
    _suggestions.forEach((recipe) {
      _missingIngredients.add({});
      recipe.ingredients.forEach((ingredient, quatity) {
        // pior forma
        //  int? userQuantity = _userQuantities[ingredient];
        int userQuantity = _userQuantities[ingredient] ?? 0;
        int difference = userQuantity - quatity;
        if (difference < 0) {
          _missingIngredients.last[ingredient] = -difference;
        }
      });
    });
  }

  void _generateMarketData() {
    final _markets = RepositoryImpl().getMarkets();
    _marketData['list'] = _marketData;
    _marketData['suggestions'] = <Map<String, dynamic>>[];

    for (int i = 0; i < _suggestions.length; i++) {
      _marketData['suggestions'].add({});
      final _missingIngredients = this._missingIngredients[i];
      final mkt = [..._markets];
      for (int i = 0; i < mkt.length; i++) {
        final a = mkt[i];
        final productsInA = _missingIngredients.keys.forEach((p) {
          // return
        });
        for (int j = 1 + i; j < mkt.length; j++) {
          final b = mkt[j];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: Navigator.of(context).pop,
                  color: Colors.red,
                ),
                const Expanded(
                    child: Text(
                  'SUGESTÕES PARA VOCÊ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700),
                )),
                const SizedBox(width: 40)
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 40,
            //     top: 20,
            //     right: 50,
            //     bottom: 20,
            //   ),
            //   child: Card(
            //     child: Padding(
            //       padding: const EdgeInsets.all(8),
            //       child: Row(
            //         children: [
            //           Icon(
            //             Icons.search,
            //             color: Colors.red,
            //           ),
            //           SizedBox(width: 8),
            //           Expanded(
            //             child: TextField(
            //               controller: _serchTextEditingController,
            //               decoration: InputDecoration.collapsed(
            //                   hintText: 'O que você quer comer ?'),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 26, bottom: 16),
            //   child: Text(
            //     'iCook',
            //     style: TextStyle(
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
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
                    onTap: () => Get.toNamed('/shop', arguments: [
                      recipe,
                      _userQuantities,
                      _missingIngredients[index],
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.asset(
                                'assets/food.jpg',
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, top: 10, bottom: 7),
                                child: Text(
                                  recipe.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF333333),
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
