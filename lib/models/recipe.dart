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

  List<String> get industrializedIngredients => [
        'arroz',
        'atum em lata',
        'azeite',
        'azeitona preta',
        'açafrão',
        'açúcar',
        'bacon',
        'batata palha',
        'caldo de legumes',
        'carne seca',
        'coentro',
        'cogumelo',
        'creme de leite',
        'farinha de mandioca',
        'farinha de rosca',
        'farinha de trigo',
        'gergelim branco',
        'gergelim preto',
        'leite',
        'milho em lata',
        'molho de tomate',
        'peito de frango',
        'queijo ralado',
        'óleo'
      ];
}
