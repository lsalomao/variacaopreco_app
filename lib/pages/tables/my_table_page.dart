import 'package:flutter/material.dart';
import 'package:variacaopreco_app/repositories/finance_repository.dart';
import 'package:variacaopreco_app/repositories/finance_repository_impl.dart';

class PriceTable extends StatefulWidget {
  const PriceTable({Key? key}) : super(key: key);

  @override
  _PriceTableState createState() => _PriceTableState();
}

class _PriceTableState extends State<PriceTable> {
  final FinanceRepository financeRepository = FinanceRepositoryImpl();
  List<dynamic> prices = [];
  double startPrice = 0;

  @override
  void initState() {
    super.initState();
    getPrices();
  }

  void getPrices() async {
    try {
      //final data = await financeRepository.getValores('PETR4');
      // List<dynamic> quotes =
      //     data['chart']['result'][0]['indicators']['quote'][0]['open'];
      // startPrice = quotes.first.toDouble();
      // prices = quotes
      //     .sublist(quotes.length - 30)
      //     .map((value) => value.toDouble())
      //     .toList();

      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Dia')),
        DataColumn(label: Text('Preço')),
      ],
      rows: prices.asMap().entries.map((entry) {
        int day = entry.key + 1;
        double price = entry.value;
        double variation = ((price - startPrice) / startPrice) * 100;
        return DataRow(cells: [
          DataCell(Text('$day')),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('R\$ $price'),
              Text('${variation.toStringAsFixed(2)}%'),
            ],
          )),
        ]);
      }).toList(),
    );
  }
}
