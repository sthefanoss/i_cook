import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_cook/data/repository.dart';
import 'package:i_cook/models/recipe.dart';
import 'package:ml_algo/ml_algo.dart' as algo;
import 'package:ml_dataframe/ml_dataframe.dart' as dataframe;

class UserIngredientsScreen extends StatefulWidget {
  const UserIngredientsScreen({Key? key}) : super(key: key);

  @override
  _UserIngredientsScreenState createState() => _UserIngredientsScreenState();
}

class _UserIngredientsScreenState extends State<UserIngredientsScreen> {
  late final Map<String, bool> favoriteRecipes;
  final quantities = <String, int>{};
  late final List<String> ingredients;

  @override
  void initState() {
    favoriteRecipes = Get.arguments;
    ingredients = RepositoryImpl().getIngredients();
    for (var i in ingredients) {
      quantities[i] = 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('iCook'),
      // ),
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
                  'SEUS INGREDIENTES',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700),
                )),
                const SizedBox(width: 40)
              ],
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Quais ingredientes você possui em casa?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: quantities.length,
                itemBuilder: (context, index) {
                  final ingredient = ingredients[index];
                  final quantity = quantities[ingredient]!;
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(child: Text(ingredient)),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => setState(() =>
                                      quantities[ingredient] = quantity + 1),
                                  icon: const Icon(Icons.add)),
                              Text(quantities[ingredient].toString()),
                              IconButton(
                                  onPressed: quantity > 0
                                      ? () => setState(() =>
                                          quantities[ingredient] = quantity - 1)
                                      : null,
                                  icon: const Icon(Icons.remove)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: findSuggestions, child: const Text('Avançar')),
            ),
          ],
        ),
      ),
    );
  }

  void findSuggestions() {
    final favoriteKeys = favoriteRecipes.keys.toList();
    // print(favoriteKeys);

    final _trainingDataSet = RepositoryImpl()
        .getRecipes()
        .where((r) => favoriteKeys.indexWhere((f) => r.name == f) != -1)
        .map(
          (recipe) => List<int>.generate(
            ingredients.length + 1,
            (index) {
              if (index == ingredients.length) {
                final isFavorite = favoriteRecipes[recipe.name]!;

                return isFavorite ? 1 : 0;
              }
              return recipe.ingredients[ingredients[index]] ?? 0;
            },
          ),
        );
    //  print(_trainingDataSet);
    final _trainRecipes = RepositoryImpl()
        .getRecipes()
        .where((r) => favoriteKeys.indexWhere((f) => r.name == f) == -1)
        .toList();

    final _outputDataSet = _trainRecipes.map(
      (recipe) => List<int>.generate(
        ingredients.length + 1,
        (index) {
          if (index == ingredients.length) {
            return 0;
          }
          return recipe.ingredients[ingredients[index]] ?? 0;
        },
      ),
    );

    final _trainingDataframe = dataframe.DataFrame(
      [
        [...ingredients, 'isFavorite'],
        ..._trainingDataSet,
      ],
      columnNames: [...ingredients, 'isFavorite'],
    );

    final _outputDataFrame = dataframe.DataFrame(
      [
        [...ingredients, 'isFavorite'],
        ..._outputDataSet,
      ],
      columnNames: [...ingredients],
    );

    final classifier = algo.KnnRegressor(
      _trainingDataframe,
      'isFavorite',
      5,
    );

    final prediction = classifier.predict(_outputDataFrame);
    final suggestions = <ScoredRecipe>[];
    final rows = prediction.rows.toList();
    for (int i = 0; i < prediction.rows.length; i++) {
      suggestions.add(ScoredRecipe.fromRecipe(
          recipe: _trainRecipes[i], score: rows[i].first));
    }
    suggestions.sort((a, b) => b.score.compareTo(a.score));
    Get.toNamed('/suggestions', arguments: [quantities, suggestions]);
  }
}
