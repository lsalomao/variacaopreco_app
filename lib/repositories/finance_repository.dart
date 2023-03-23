import 'package:variacaopreco_app/models/ativo_chart_model.dart';

abstract class FinanceRepository {
  Future<List<AtivoChartModel>> getValores(String ativo);
}
