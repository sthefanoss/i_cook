class Recipe {
  Recipe({
    required this.name,
    required this.ingredients,
  });

  final String name;
  final Map<String, int> ingredients;
  @override
  String toString() => 'Recipe($name,$ingredients)';
}

class ScoredRecipe extends Recipe {
  ScoredRecipe({
    required String name,
    required Map<String, int> ingredients,
    required this.score,
  }) : super(name: name, ingredients: ingredients);

  ScoredRecipe.fromRecipe({required Recipe recipe, required this.score})
      : super(name: recipe.name, ingredients: recipe.ingredients);

  final double score;

  @override
  String toString() => 'ScoredRecipe($name,$score)';
}
