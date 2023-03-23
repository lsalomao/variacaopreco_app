import 'package:flutter/material.dart';
import 'package:variacaopreco_app/models/ativo_chart_model.dart';
import 'package:variacaopreco_app/pages/componentes/line_chart.dart';
import 'package:variacaopreco_app/repositories/finance_repository.dart';
import 'package:variacaopreco_app/repositories/finance_repository_impl.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final formkey = GlobalKey<FormState>();
  final FinanceRepository financeRepository = FinanceRepositoryImpl();
  List<AtivoChartModel> ativos = [];
  final ativoEC = TextEditingController();
  bool mostrarGrafico = false;

  @override
  void dispose() {
    ativoEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal,
                  style: BorderStyle.solid,
                  width: 2,
                ),
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: [
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: ativoEC,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ativo obrigatório';
                            }

                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final valid =
                                formkey.currentState?.validate() ?? false;

                            if (valid) {
                              var result = await financeRepository
                                  .getValores(ativoEC.text);

                              setState(() {
                                mostrarGrafico = true;
                                ativos = result;
                              });
                              FocusScope.of(context).unfocus();
                            }
                          },
                          child: const Text("buscar"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Variação',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: !mostrarGrafico,
                    child: const CircularProgressIndicator(),
                  ),
                  Visibility(
                    visible: mostrarGrafico,
                    child: MyLineChart(ativos),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
