import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:variacaopreco_app/models/ativo_chart_model.dart';
import 'package:intl/intl.dart';

class MyLineChart extends StatelessWidget {
  final List<AtivoChartModel> points;
  const MyLineChart(this.points, {Key? key}) : super(key: key);

  getDate(int index) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(points[index].data.toInt() * 1000);

    return DateFormat('dd/MM').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
              getTooltipItems: (data) {
                return data.map((item) {
                  final date = getDate(item.spotIndex);
                  return LineTooltipItem(
                    item.y.toStringAsFixed(2),
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: '\n $date',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(.5),
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              isStrokeCapRound: true,
              barWidth: 2,
              color: Colors.white,
              spots: points
                  .map(
                    (point) => FlSpot(point.index, point.valor),
                  )
                  .toList(),
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}

FlGridData get gridData => FlGridData(show: false);

FlTitlesData get titlesData => FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles,
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // leftTitles(),
      ),
    );

SideTitles get bottomTitles => SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: 1,
      getTitlesWidget: bottomTitleWidgets,
    );

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 8,
  );

  final date = DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000);
  final dateFormat = DateFormat('dd/MM/yyyy');
  final dtFormatado = dateFormat.format(date);

  Widget text = Text(dtFormatado, style: style);

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 1,
    child: text,
  );
}

SideTitles leftTitles() => SideTitles(
      getTitlesWidget: leftTitleWidgets,
      showTitles: false,
      interval: 1,
      reservedSize: 40,
    );

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 8,
  );
  String text = value.toString();

  return Text(text, style: style, textAlign: TextAlign.center);
}
