import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_cook/data/repository.dart';

import '../../models/market.dart';
import '../../models/recipe.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late final Recipe recipe;
  late final Map<String, int> _missingIngredients;
  late final Map<String, int> _userQuantities;
  late final List<Market> _markets;
  late Market _selectedMarket;

  @override
  void initState() {
    recipe = Get.arguments[0];
    _userQuantities = Get.arguments[1];
    _missingIngredients = Get.arguments[2];
    // _getMissingIngridients();
    _loadMarketData();
    super.initState();
  }

  // void _getMissingIngridients() {
  //   recipe.ingredients.forEach((ingredient, quatity) {
  //     // pior forma
  //     //  int? userQuantity = _userQuantities[ingredient];
  //     int userQuantity = _userQuantities[ingredient] ?? 0;
  //     int difference = userQuantity - quatity;
  //     if (difference < 0) {
  //       _missingIngredients[ingredient] = -difference;
  //     }
  //   });
  // }

  void _loadMarketData() {
    _markets = RepositoryImpl().getMarkets();
    _selectedMarket = _markets.first;
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
                  'PEDIDO IFOOD MERCADO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700),
                )),
                const SizedBox(width: 40)
              ],
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  bool isSelected = _markets[index] == _selectedMarket;

                  final Widget child = GestureDetector(
                    onTap: () =>
                        setState(() => _selectedMarket = _markets[index]),
                    child: SizedBox(
                      width: 170,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                                height: 65,
                                child: Icon(Icons.shop, color: Colors.red)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                _markets[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                '55-60 min',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                  if (isSelected) {
                    return Container(
                      child: child,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4)),
                    );
                  }
                  return child;
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 14, left: 28, bottom: 23),
              child: Text(
                'Itens da Sacola',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _missingIngredients.length,
                itemBuilder: (context, index) {
                  final String ingredient =
                      _missingIngredients.keys.toList()[index];
                  // print(_selectedMarket.products);
                  final double price =
                      _selectedMarket.products[ingredient] ?? 0;
                  bool isAvailable = price != 0;
                  // print(price);
                  return Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 32),
                          const Icon(
                            Icons.dining_rounded,
                            size: 40,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(ingredient),
                                Text(
                                  'R\$ ${price.toStringAsFixed(2).replaceFirst('.', ',')}',
                                  style: TextStyle(
                                    color: isAvailable
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey[300],
                            ),
                            alignment: Alignment.center,
                            child: Text(isAvailable
                                ? _missingIngredients[ingredient].toString()
                                : 'indisponível'),
                          ),
                          const SizedBox(width: 32),
                        ],
                      ),
                      const Padding(
                          padding: EdgeInsets.only(left: 32, right: 32),
                          child: Divider()),
                    ],
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 32, right: 32),
              child: Divider(),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Row(
                children: [
                  Text('Disponíveis nesta loja'),
                  Spacer(),
                  Text('0'),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Row(
                children: [
                  Text('Indisponíveis nesta loja'),
                  Spacer(),
                  Text('0'),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Ver sacola'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
