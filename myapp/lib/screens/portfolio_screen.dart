import 'dart:math';
import 'package:flutter/material.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  List<Holding> holdings = [];
  List<Stock> trendyStocks = [
    Stock(symbol: 'AAPL'),
    Stock(symbol: 'GOOGL'),
    Stock(symbol: 'AMZN'),
    Stock(symbol: 'TSLA'),
    Stock(symbol: 'MSFT'),
  ];
  double netWorth = 0;

  @override
  void initState() {
    super.initState();
    fetchTrendyStocksData();
  }

  Future<void> fetchTrendyStocksData() async {
    for (var stock in trendyStocks) {
      await stock.fetchStockData();
    }
    setState(() {});
  }

  void addHolding(Stock stock, double quantity) {
    final holding = Holding(stock: stock, quantity: quantity);
    setState(() {
      holdings.add(holding);
      calculateNetWorth();
    });
  }

  void calculateNetWorth() {
    double total = 0;
    for (var holding in holdings) {
      total += holding.quantity * holding.stock.price;
    }
    setState(() {
      netWorth = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Portfolio'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Trending'),
              Tab(text: 'Holdings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Trending Stocks View
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
              ),
              itemCount: trendyStocks.length,
              itemBuilder: (context, index) {
                final stock = trendyStocks[index];
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stock.symbol,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Price: \$${stock.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Change: ${(stock.percentChange * 100).toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 16,
                          color: stock.percentChange >= 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Holdings View
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Net Worth: \$${netWorth.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: holdings.length,
                    itemBuilder: (context, index) {
                      final holding = holdings[index];
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              holding.stock.symbol,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Quantity: ${holding.quantity}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Price: \$${holding.stock.price.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddHoldingDialog(
                        trendyStocks: trendyStocks,
                        addHolding: addHolding,
                      ),
                    );
                  },
                  child: Text('Add Holding'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Holding {
  final Stock stock;
  final double quantity;

  Holding({required this.stock, required this.quantity});
}

class Stock {
  final String symbol;
  double price;
  double percentChange;

  Stock({required this.symbol, this.price = 0, this.percentChange = 0});

  Future<void> fetchStockData() async {
    // Simulate a delay to mimic an API call
    await Future.delayed(Duration(seconds: 1));

    // Generate dummy data based on the current time
    final now = DateTime.now();
    final random = Random(now.millisecondsSinceEpoch);
    price = random.nextDouble() * 500;
    percentChange = random.nextDouble() * 0.1 - 0.05;
  }
}

class AddHoldingDialog extends StatefulWidget {
  final List<Stock> trendyStocks;
  final Function(Stock, double) addHolding;

  AddHoldingDialog({required this.trendyStocks, required this.addHolding});

  @override
  _AddHoldingDialogState createState() => _AddHoldingDialogState();
}

class _AddHoldingDialogState extends State<AddHoldingDialog> {
  Stock? selectedStock;
  double quantity = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Holding'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<Stock>(
            value: selectedStock,
            onChanged: (Stock? newValue) {
              setState(() {
                selectedStock = newValue;
              });
            },
            items: widget.trendyStocks.map<DropdownMenuItem<Stock>>((Stock stock) {
              return DropdownMenuItem<Stock>(
                value: stock,
                child: Text(stock.symbol),
              );
            }).toList(),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                quantity = double.tryParse(value) ?? 0;
              });
            },
            decoration: InputDecoration(
              labelText: 'Quantity',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedStock != null) {
              widget.addHolding(selectedStock!, quantity);
              Navigator.pop(context);
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}