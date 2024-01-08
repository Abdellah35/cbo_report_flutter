import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
            minX: 0,
            maxX: 11,
            minY: 0,
            maxY: 6,
            gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: const Color(0xff37434d),
                    strokeWidth: 1,
                  );
                },
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: Color(0xff37434d),
                    strokeWidth: 1,
                  );
                }),
            borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1)),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 3),
                  FlSpot(2.6, 2),
                  FlSpot(3.6, 2.3),
                  FlSpot(4, 2.5),
                  FlSpot(5.2, 3),
                  FlSpot(6, 2),
                  FlSpot(8, 3),
                  FlSpot(11, 4),
                ],
                isCurved: true,
                color: const Color(0xff02d39a),
                barWidth: 5,
                belowBarData: BarAreaData(
                    show: true,
                    color: const Color(0xff02d39a).withOpacity(0.3)),
              )
            ]),
        // swapAnimationDuration: const Duration(milliseconds: 150), // Optional
        // swapAnimationCurve: Curves.linear, // Optional
      );
}
