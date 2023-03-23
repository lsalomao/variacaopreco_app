import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:variacaopreco_app/models/ativo_chart_model.dart';

import './finance_repository.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  @override
  Future<List<AtivoChartModel>> getValores(String ativo) async {
    try {
      final result =
          await Dio().get('http://10.0.2.2:5000/valoresativo?ativo=$ativo');

      final List<AtivoChartModel> ativos = [];

      final openPrices =
          result.data['chart']['result'][0]['indicators']['quote'][0]['open'];

      final dates =
          result.data['chart']['result'][0]['timestamp'].cast<int>().toList();

      for (var i = 0; i < openPrices.length; i++) {
        AtivoChartModel ativo = AtivoChartModel(
          valor: openPrices[i],
          index: i.toDouble(),
          data: dates[i].toDouble(),
        );

        ativos.add(ativo);
      }

      return ativos;
    } on DioError catch (e) {
      log("Error ao consultar", error: e.error);
      throw Exception("Erro ao consultar a api");
    }
  }
}
