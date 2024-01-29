// import 'package:cbo_report/features/user_auth/presentation/pages/titles.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ChartDatas {
//   LineChartData getChartData(var reportModel) {
//     List<FlSpot> creditData = [];

//     List<FlSpot> debitData = [];
//     debitData.add(const FlSpot(0, 0.0));
//     for (int i = 0; i < reportModel?.length; i++) {
//       debitData
//           .add(FlSpot(i + 1, double.parse(reportModel?[i]['noDebit']) / 10000));
//       print(double.parse(reportModel?[i]['time']));
//     }

//     List<FlSpot> nonCashData = [];
//     nonCashData.add(const FlSpot(0, 0.0));
//     for (int i = 0; i < reportModel?.length; i++) {
//       nonCashData
//           .add(FlSpot(i + 1, double.parse(reportModel?[i]['noTr']) / 10000));
//     }
//     List<FlSpot> selectedData;
//     Widget Function(double, TitleMeta) selectedSideTitle;

//     switch (selectedTransactionType) {
//       case 'Credit':
//         selectedData = creditData;
//         selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
//         break;
//       case 'Debit':
//         selectedData = debitData;
//         selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
//         break;
//       case 'Non-Cash':
//         selectedData = nonCashData;
//         selectedSideTitle = CustomTitles.leftTitleNonCashAmtWidgets;
//         break;
//       default:
//         selectedData = [];
//         selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
//     }

//     var maxXValue = 6.0;
//     Widget Function(double, TitleMeta) selectedDate;

//     switch (selectedDateRange) {
//       case 'Today':
//         selectedDate = CustomTitles.bottomTitleHoursWidgets;
//         maxXValue = 6.0;
//         DateTime now = DateTime.now();
//         DateFormat format = DateFormat('dd-MMM-yy');
//         date = format.format(now);
//         creditData.add(const FlSpot(0, 0.0));
//         for (int i = 0; i < reportModel?.length; i++) {
//           creditData.add(
//               FlSpot(i + 1, double.parse(reportModel?[i]['noCredit']) / 10000));
//         }
//         break;
//       case 'This Week':
//         selectedDate = CustomTitles.bottomTitleWeekWidgets;
//         maxXValue = 6.0;
//         date = startOfWeek;
//         creditData.add(const FlSpot(0, 0.0));
//         for (int i = 0; i < reportModel?.length; i++) {
//           if (reportModel?[i]['time'] == '14') {
//             creditData.add(FlSpot(
//                 i + 1, double.parse(reportModel?[i]['noCredit']) / 10000));
//             print(reportModel?[i]['time']);
//           }
//         }
//         break;
//       case 'This Month':
//         selectedDate = CustomTitles.bottomTitleMonthWidgets;
//         maxXValue = 4.0;
//         date = startOfMonth;
//         break;
//       default:
//         selectedDate = CustomTitles.bottomTitleHoursWidgets;
//     }
//     return LineChartData(
//       lineTouchData: const LineTouchData(enabled: false),
//       gridData: FlGridData(
//         show: true,
//         drawHorizontalLine: true,
//         verticalInterval: 1,
//         horizontalInterval: 1,
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//         getDrawingHorizontalLine: (value) {
//           return const FlLine(
//             color: Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             getTitlesWidget: selectedDate,
//             interval: 1,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: selectedSideTitle,
//             reservedSize: 30,
//             interval: 1,
//           ),
//           axisNameWidget: const Text(
//             "No. TR per 10,000",
//             style: TextStyle(fontSize: 12, color: Colors.cyan),
//           ),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d)),
//       ),
//       minX: 0,
//       maxX: maxXValue,
//       minY: 0,
//       maxY: 10,
//       lineBarsData: [
//         LineChartBarData(
//           spots: selectedData,
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: [
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!,
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!,
//             ],
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: [
//                 ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.1),
//                 ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.1),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   LineChartData getAmtChartData(var reportModel) {
//     List<FlSpot> creditData = [];
//     creditData.add(const FlSpot(0, 0.0));
//     for (int i = 0; i < reportModel?.length; i++) {
//       creditData.add(FlSpot(
//           i + 1,
//           double.parse(reportModel?[i]['ttlCrAmt']) /
//               100000000)); // hundred millions
//     }

//     List<FlSpot> debitData = [];
//     debitData.add(const FlSpot(0, 0.0));
//     for (int i = 0; i < reportModel?.length; i++) {
//       debitData.add(FlSpot(
//           i + 1,
//           double.parse(reportModel?[i]['ttlDrAmt']) /
//               100000000)); // hundred millions
//     }

//     List<FlSpot> nonCashData = [];
//     nonCashData.add(const FlSpot(0, 0.0));
//     for (int i = 0; i < reportModel?.length; i++) {
//       nonCashData.add(FlSpot(i + 1,
//           double.parse(reportModel?[i]['ttlAmount']) / 1000000000)); //billion
//     }
//     List<FlSpot> selectedData;
//     var labelMeasure = "TR Amount per 100M";
//     Widget Function(double, TitleMeta) selectedSideTitle;

//     switch (selectedTransactionType) {
//       case 'Credit':
//         selectedData = creditData;
//         selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
//         labelMeasure = "TR Amount per 100M";
//         break;
//       case 'Debit':
//         selectedData = debitData;
//         selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
//         labelMeasure = "TR Amount per 100M";
//         break;
//       case 'Non-Cash':
//         selectedData = nonCashData;
//         selectedSideTitle = CustomTitles.leftTitleNonCashAmtWidgets;
//         labelMeasure = "TR Amount per billion";
//         break;
//       default:
//         selectedData = [];
//         selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
//     }

//     var maxXValue = 6.0;
//     Widget Function(double, TitleMeta) selectedDate;
//     switch (selectedDateRange) {
//       case 'Today':
//         selectedDate = CustomTitles.bottomTitleHoursWidgets;
//         maxXValue = 6.0;
//         DateTime now = DateTime.now();
//         DateFormat format = DateFormat('dd-MMM-yy');
//         date = format.format(now);
//         break;
//       case 'This Week':
//         selectedDate = CustomTitles.bottomTitleWeekWidgets;
//         maxXValue = 6.0;
//         date = startOfWeek;
//         break;
//       case 'This Month':
//         selectedDate = CustomTitles.bottomTitleMonthWidgets;
//         maxXValue = 4.0;
//         date = startOfMonth;
//         break;
//       default:
//         selectedDate = CustomTitles.bottomTitleHoursWidgets;
//     }
//     return LineChartData(
//       lineTouchData: const LineTouchData(enabled: false),
//       gridData: FlGridData(
//         show: true,
//         drawHorizontalLine: true,
//         verticalInterval: 2,
//         horizontalInterval: 1,
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//         getDrawingHorizontalLine: (value) {
//           return const FlLine(
//             color: Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             getTitlesWidget: selectedDate,
//             interval: 1,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: selectedSideTitle,
//             reservedSize: 20,
//             interval: 1,
//           ),
//           axisNameWidget: Text(
//             labelMeasure,
//             style: const TextStyle(fontSize: 12, color: Colors.cyan),
//           ),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d)),
//       ),
//       minX: 0,
//       maxX: maxXValue,
//       minY: 0,
//       maxY: 10,
//       lineBarsData: [
//         LineChartBarData(
//           spots: selectedData,
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: [
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!,
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!,
//             ],
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: [
//                 ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.1),
//                 ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.1),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   LineChartData avgData() {
//     return LineChartData(
//       lineTouchData: const LineTouchData(enabled: false),
//       gridData: FlGridData(
//         show: true,
//         drawHorizontalLine: true,
//         verticalInterval: 1,
//         horizontalInterval: 1,
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//         getDrawingHorizontalLine: (value) {
//           return const FlLine(
//             color: Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             getTitlesWidget: CustomTitles.bottomTitleHoursWidgets,
//             interval: 1,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: CustomTitles.leftTitleCashAmtWidgets,
//             reservedSize: 42,
//             interval: 1,
//           ),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d)),
//       ),
//       minX: 0,
//       maxX: 6,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: const [
//             FlSpot(1, 3.44),
//             FlSpot(2, 3.44),
//             FlSpot(3, 3.44),
//             FlSpot(4, 3.44),
//             FlSpot(5, 3.44),
//             FlSpot(6, 3.44),
//           ],
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: [
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!,
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!,
//             ],
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: [
//                 ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.1),
//                 ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.1),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
