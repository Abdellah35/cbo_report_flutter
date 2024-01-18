import 'package:cbo_report/features/user_auth/presentation/pages/titles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<Color> gradientColors = [Colors.cyan, Colors.blue];
  List<Color> gradientColors2 = [
    const Color.fromARGB(255, 255, 0, 0),
    Colors.red
  ];

  bool showAvg = false;
  String selectedTransactionType = 'Credit';
  String selectedDateRange = 'Today';
  var date = DateFormat('dd-MMM-yy').format(DateTime.now());

  var startOfWeek = DateFormat('dd-MMM-yy').format(
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)));

  var startOfMonth = DateFormat('dd-MMM-yy')
      .format(DateTime.now().subtract(Duration(days: DateTime.now().day - 1)));

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance
        .collection('daily-report')
        .where("fbusinessDate", isEqualTo: date.toUpperCase())
        .orderBy('time')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: documentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var reportModel = snapshot.data?.docs;
            return Container(
              color: const Color.fromARGB(255, 10, 184, 239),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      _dropDate(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 20),
                      _buildOptionButton('Credit'),
                      const SizedBox(width: 20),
                      _buildOptionButton('Debit'),
                      const SizedBox(width: 20),
                      _buildOptionButton('Non-Cash'),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.all(16),
                    child: Stack(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.70,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 18,
                              left: 12,
                              top: 24,
                              bottom: 12,
                            ),
                            child: LineChart(
                              showAvg ? avgData() : getChartData(reportModel),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: SizedBox(
                            width: 60,
                            height: 34,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  showAvg = !showAvg;
                                });
                              },
                              child: Text(
                                'avg',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: showAvg
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.all(16),
                    child: Stack(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.70,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 18,
                              left: 12,
                              top: 24,
                              bottom: 12,
                            ),
                            child: LineChart(
                              showAvg
                                  ? avgData()
                                  : getAmtChartData(reportModel),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: SizedBox(
                            width: 60,
                            height: 34,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  showAvg = !showAvg;
                                });
                              },
                              child: Text(
                                'avg',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: showAvg
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Container(color: const Color.fromARGB(255, 10, 184, 239));
          }
        });
  }

  Widget _dropDate() {
    return Card(
      color: const Color.fromARGB(255, 10, 184, 239),
      child: DropdownButton<String>(
        value: selectedDateRange,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          setState(() {
            selectedDateRange = value!;
          });
        },
        items: ['Today', 'This Week', 'This Month']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedTransactionType = option;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white;
              }
              if (selectedTransactionType == option) {
                return Colors.orange;
              }
              return Colors.white;
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              }
              return Colors.orange;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(5),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: selectedTransactionType == option
                ? Colors.white
                : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  LineChartData getChartData(var reportModel) {
    List<FlSpot> creditData = [];

    List<FlSpot> debitData = [];
    debitData.add(const FlSpot(0, 0.0));
    for (int i = 0; i < reportModel?.length; i++) {
      debitData
          .add(FlSpot(i + 1, double.parse(reportModel?[i]['noDebit']) / 10000));
      print(double.parse(reportModel?[i]['time']));
    }

    List<FlSpot> nonCashData = [];
    nonCashData.add(const FlSpot(0, 0.0));
    for (int i = 0; i < reportModel?.length; i++) {
      nonCashData
          .add(FlSpot(i + 1, double.parse(reportModel?[i]['noTr']) / 10000));
    }
    List<FlSpot> selectedData;
    Widget Function(double, TitleMeta) selectedSideTitle;

    switch (selectedTransactionType) {
      case 'Credit':
        selectedData = creditData;
        selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
        break;
      case 'Debit':
        selectedData = debitData;
        selectedSideTitle = leftTitleCashAmtWidgets;
        break;
      case 'Non-Cash':
        selectedData = nonCashData;
        selectedSideTitle = leftTitleNonCashAmtWidgets;
        break;
      default:
        selectedData = [];
        selectedSideTitle = leftTitleCashAmtWidgets;
    }

    var maxXValue = 6.0;
    Widget Function(double, TitleMeta) selectedDate;

    switch (selectedDateRange) {
      case 'Today':
        selectedDate = bottomTitleHoursWidgets;
        maxXValue = 6.0;
        DateTime now = DateTime.now();
        DateFormat format = DateFormat('dd-MMM-yy');
        date = format.format(now);
        creditData.add(const FlSpot(0, 0.0));
        for (int i = 0; i < reportModel?.length; i++) {
          creditData.add(
              FlSpot(i + 1, double.parse(reportModel?[i]['noCredit']) / 10000));
        }
        break;
      case 'This Week':
        selectedDate = bottomTitleWeekWidgets;
        maxXValue = 6.0;
        date = startOfWeek;
        creditData.add(const FlSpot(0, 0.0));
        for (int i = 0; i < reportModel?.length; i++) {
          if (reportModel?[i]['time'] == '14') {
            creditData.add(FlSpot(
                i + 1, double.parse(reportModel?[i]['noCredit']) / 10000));
            print(reportModel?[i]['time']);
          }
        }
        break;
      case 'This Month':
        selectedDate = bottomTitleMonthWidgets;
        maxXValue = 4.0;
        date = startOfMonth;
        break;
      default:
        selectedDate = bottomTitleHoursWidgets;
    }
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: selectedDate,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: selectedSideTitle,
            reservedSize: 30,
            interval: 1,
          ),
          axisNameWidget: const Text(
            "No. TR per 10,000",
            style: TextStyle(fontSize: 12, color: Colors.cyan),
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: maxXValue,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: selectedData,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LineChartData getAmtChartData(var reportModel) {
    List<FlSpot> creditData = [];
    creditData.add(const FlSpot(0, 0.0));
    for (int i = 0; i < reportModel?.length; i++) {
      creditData.add(FlSpot(
          i + 1,
          double.parse(reportModel?[i]['ttlCrAmt']) /
              100000000)); // hundred millions
    }

    List<FlSpot> debitData = [];
    debitData.add(const FlSpot(0, 0.0));
    for (int i = 0; i < reportModel?.length; i++) {
      debitData.add(FlSpot(
          i + 1,
          double.parse(reportModel?[i]['ttlDrAmt']) /
              100000000)); // hundred millions
    }

    List<FlSpot> nonCashData = [];
    nonCashData.add(const FlSpot(0, 0.0));
    for (int i = 0; i < reportModel?.length; i++) {
      nonCashData.add(FlSpot(i + 1,
          double.parse(reportModel?[i]['ttlAmount']) / 1000000000)); //billion
    }
    List<FlSpot> selectedData;
    var labelMeasure = "TR Amount per 100M";
    Widget Function(double, TitleMeta) selectedSideTitle;

    switch (selectedTransactionType) {
      case 'Credit':
        selectedData = creditData;
        selectedSideTitle = leftTitleCashAmtWidgets;
        labelMeasure = "TR Amount per 100M";
        break;
      case 'Debit':
        selectedData = debitData;
        selectedSideTitle = leftTitleCashAmtWidgets;
        labelMeasure = "TR Amount per 100M";
        break;
      case 'Non-Cash':
        selectedData = nonCashData;
        selectedSideTitle = leftTitleNonCashAmtWidgets;
        labelMeasure = "TR Amount per billion";
        break;
      default:
        selectedData = [];
        selectedSideTitle = leftTitleCashAmtWidgets;
    }

    var maxXValue = 6.0;
    Widget Function(double, TitleMeta) selectedDate;
    switch (selectedDateRange) {
      case 'Today':
        selectedDate = bottomTitleHoursWidgets;
        maxXValue = 6.0;
        DateTime now = DateTime.now();
        DateFormat format = DateFormat('dd-MMM-yy');
        date = format.format(now);
        break;
      case 'This Week':
        selectedDate = bottomTitleWeekWidgets;
        maxXValue = 6.0;
        date = startOfWeek;
        break;
      case 'This Month':
        selectedDate = bottomTitleMonthWidgets;
        maxXValue = 4.0;
        date = startOfMonth;
        break;
      default:
        selectedDate = bottomTitleHoursWidgets;
    }
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 2,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: selectedDate,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: selectedSideTitle,
            reservedSize: 20,
            interval: 1,
          ),
          axisNameWidget: Text(
            labelMeasure,
            style: const TextStyle(fontSize: 12, color: Colors.cyan),
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: maxXValue,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: selectedData,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleHoursWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleCashAmtWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 3.44),
            FlSpot(2, 3.44),
            FlSpot(3, 3.44),
            FlSpot(4, 3.44),
            FlSpot(5, 3.44),
            FlSpot(6, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
