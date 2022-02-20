import 'dart:math';

import 'package:i_cook/models/market.dart';
import 'package:i_cook/models/recipe.dart';

abstract class Repository {
  List<Recipe> getRecipes([int quantity = 0]);
  List<String> getIngredients();
  List<Market> getMarkets();
}

class RepositoryImpl implements Repository {
  late final List<Recipe> _recipes;
  late final List<String> _marketNames;

  @override
  List<Recipe> getRecipes([int quantity = 0]) {
    final shuffledData = [..._recipes]..shuffle();
    if (quantity == 0) {
      return shuffledData;
    }

    return shuffledData.sublist(0, quantity);
  }

  @override
  List<String> getIngredients() {
    final _list = <String>[];
    RepositoryImpl().getRecipes().forEach((element) {
      element.ingredients.forEach((key, value) {
        if (!_list.contains(key)) _list.add(key);
      });
    });
    _list.sort();
    return _list;
  }

  @override
  List<Market> getMarkets() {
    final _random = Random(0);
    final ingredients = getIngredients();
    return _marketNames.map<Market>((name) {
      int itensQuantity = 60 + _random.nextInt(20);
      final products = <String, double>{};
      for (int i = 0; i < itensQuantity && i < ingredients.length; i++) {
        final product = ingredients[_random.nextInt(ingredients.length)];
        products[product] = 10 + 10 * _random.nextDouble();
      }
      return Market(name: name, products: products);
    }).toList();
  }

  RepositoryImpl() {
    _recipes = [
      Recipe(
        name: 'Strogonoff de frango',
        ingredients: {
          'peito de frango': 3,
          'alho': 1,
          'cebola': 1,
          'manteiga': 1,
          'cogumelo': 1,
          'creme de leite': 1,
          'sal': 1,
          'batata palha': 1,
        },
      ),
      Recipe(
        name: 'Guacamole',
        ingredients: {
          'abacate': 3,
          'cabola': 1,
          'coentro': 1,
          'pimenta': 1,
          'sal': 1,
          'azeite': 1,
        },
      ),
      Recipe(
        name: 'Vinagrete de Polvo',
        ingredients: {
          'polvo': 3,
          'cebola': 1,
          'tomate': 1,
          'azeite': 1,
          'coentro': 1,
        },
      ),
      Recipe(
        name: 'Salada de Batata',
        ingredients: {
          'maionese': 3,
          'batata': 5,
          'cenoura': 1,
          'cebola': 1,
          'mostarda': 1,
          'ovo': 1,
        },
      ),
      Recipe(
        name: 'Arroz de Pato',
        ingredients: {
          'pato': 1,
          'arroz': 1,
          'azeitona preta': 1,
          'linguiça calabresa': 1,
          'cebola': 1,
        },
      ),
      Recipe(
        name: 'Risoto Milanês',
        ingredients: {
          'arroz': 3,
          'caldo de legumes': 1,
          'queijo': 1,
          'mainteiga': 1,
          'açafrão': 1,
          'cebola': 1,
        },
      ),
      Recipe(
        name: 'Feijoada',
        ingredients: {
          'feijão preto': 3,
          'cebola': 2,
          'alho': 5,
          'carne seca': 1,
          'lombo defumado': 1,
          'linguiça paio': 1,
          'linguiça calabresa': 1,
          'costela defumada': 1,
          'orelha salgada': 1,
          'arroz': 1,
          'laranja seleta': 1,
          'couve mineira': 1,
        },
      ),
      Recipe(
        name: 'Camarão com Chuchú',
        ingredients: {
          'camarão': 1,
          'chuchú': 1,
          'tomate': 1,
          'cebola': 1,
          'salsinha': 1,
        },
      ),
      Recipe(
        name: 'Paella Valenciana',
        ingredients: {
          'peito de frango': 3,
          'linguiça calabresa': 1,
          'arroz': 1,
          'paelleiro': 1,
          'camarão': 1,
          'mexilhão': 1,
          'ervilha em lata': 1,
          'cebola': 1,
          'alho': 1,
          'pimentão vermelho': 1,
        },
      ),
      Recipe(
        name: 'Bife de Chorizo',
        ingredients: {
          'bife chorizo': 2,
          'cebola': 1,
          'pimentão': 1,
          'azeite': 1,
          'coentro': 1,
        },
      ),
      Recipe(
        name: 'Farofa de Banana com Ovo',
        ingredients: {
          'farinha de mandioca': 1,
          'cebola': 1,
          'ovo': 1,
          'banana': 1,
          'manteiga': 1,
        },
      ),
      Recipe(
        name: 'Sunomono',
        ingredients: {
          'pepino': 3,
          'açúcar': 1,
          'vinagre de arroz': 1,
          'gergelim preto': 1,
          'gergelim branco': 1,
          'kani': 1,
        },
      ),
      Recipe(
        name: 'Tabule',
        ingredients: {
          'trigo de kibe': 1,
          'cebola': 1,
          'tomate': 1,
          'pepino': 1,
          'hortelâ': 1,
        },
      ),
      Recipe(
        name: 'Salada De Ovo',
        ingredients: {
          'ovo': 6,
          'maionese': 1,
          'cebola': 1,
          'salsinha': 1,
        },
      ),
      Recipe(
        name: 'Salada De Atum',
        ingredients: {
          'atum em lata': 6,
          'maionese': 1,
          'cebola': 1,
          'salsinha': 1,
        },
      ),
      Recipe(
        name: 'Salada Grega',
        ingredients: {
          'pepino': 1,
          'tomate': 1,
          'azeitona preta': 1,
          'queijo': 1,
        },
      ),
      Recipe(
        name: 'Hummus Tahine',
        ingredients: {
          'hummus': 1,
          'tahine': 1,
          'alho': 1,
        },
      ),
      Recipe(
        name: 'Tzik Tzak',
        ingredients: {
          'yogurte': 3,
          'alho': 1,
          'pepino': 1,
          'sal': 1,
        },
      ),
      Recipe(
        name: 'Babaganush',
        ingredients: {
          'berinjela': 3,
          'alho': 1,
          'coentro': 1,
          'sal': 1,
        },
      ),
      Recipe(
        name: 'Panqueca de carne',
        ingredients: {
          'farinha de trigo': 1,
          'leite': 1,
          'queijo ralado': 1,
          'ovo': 1,
          'carne moida': 1,
          'molho de tomate': 1,
          'sal': 1,
        },
      ),
      Recipe(
        name: 'Pernil',
        ingredients: {
          'pernil suino': 3,
          'cabola': 1,
          'alho': 1,
          'pimenta do reino': 1,
          'tomilho': 1,
          'salvia': 1,
          'alecrim': 1,
          'sal': 1,
        },
      ),
      Recipe(
        name: 'Bife à Milanesa',
        ingredients: {
          'patinho': 3,
          'ovo': 1,
          'farinha de trigo': 1,
          'farinha de rosca': 1,
          'sal': 1,
          'oleo de girassol': 1,
        },
      ),
      Recipe(
        name: 'Ceviche',
        ingredients: {
          'file de linguado': 1,
          'alho': 1,
          'cebola roxa': 1,
          'milho crocante': 1,
          'coentro fresco': 1,
          'pimenta jalapeno': 1,
          'sal': 1,
        },
      ),
      Recipe(
        name: 'Salmão ao forno com molho de champignon',
        ingredients: {
          'azeite': 1,
          'limão': 1,
          'cebola': 1,
          'cogumelo': 1,
          'coentro': 1,
          'sal': 1,
          'salvia': 1,
          'tomilho': 1,
          'pimenta': 1,
        },
      ),
      Recipe(
        name: 'Carne de panela',
        ingredients: {
          'lagarto redondo': 3,
          'alho': 3,
          'cominho': 1,
          'limão': 3,
          'óleo': 4,
          'cebola': 4,
          'pimentão': 1,
          'tomate': 4,
          'sal': 1,
          'batata': 3,
        },
      ),
      Recipe(
        name: 'Spaggetti Carbonara',
        ingredients: {
          'ovo': 3,
          'bacon': 1,
          'spaggetti': 1,
          'salsinha': 1,
        },
      ),
      Recipe(
        name: 'Torta de frango',
        ingredients: {
          'ovo': 2,
          'leite': 2,
          'óleo': 1,
          'queijo ralado': 1,
          'farinha de trigo': 2,
          'fermento': 1,
        },
      ),
      Recipe(
        name: 'Fusilli a la Melanzanna',
        ingredients: {
          'fuzzili': 1,
          'berinjela': 2,
          'azeite': 1,
          'alho': 1,
          'cebola': 2,
          'salsinha': 1,
        },
      ),
      Recipe(
        name: 'Salpicão de Frango Defumado',
        ingredients: {
          'peito de frango': 1,
          'maionese': 2,
          'repolho': 1,
          'cebola': 1,
          'maçã': 2,
          'cenoura': 1,
          'milho em lata': 1,
        },
      ),
    ];

    _marketNames = [
      'Pão de Açúcar',
      'Zona Sul',
      'Super Market',
      'Carrefour',
      'Rede Economia',
      'Assaí',
      'Seu Zé',
      'Varejão',
      'Hortifruti',
      'SuPertinho',
      'Baratão',
    ];
  }
}
