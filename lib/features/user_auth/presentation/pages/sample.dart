import 'package:cbo_report/features/user_auth/presentation/pages/date_options.dart';
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

  var today;

  var yesterday;

  var startOfWeek;

  var startOfMonth;

  var reportModelList;

  @override
  Widget build(BuildContext context) {
    today = DateFormat('yyyyMMdd').format(DateTime.now());
    yesterday = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(const Duration(days: 1)));
    startOfWeek = DateFormat('yyyyMMdd').format(
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)));
    startOfMonth = DateFormat('yyyyMMdd').format(
        DateTime.now().subtract(Duration(days: DateTime.now().day - 1)));

    Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance
        .collection('daily-report')
        .orderBy("fbusinessDate", descending: false)
        .orderBy("time", descending: false)
        .snapshots();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const BackButtonIcon(),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Cooplogo.png",
                height: 40,
                width: 75,
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        body: mainBody(documentStream),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> mainBody(var documentStreams) {
    return StreamBuilder<QuerySnapshot>(
        stream: documentStreams,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return baseBody(snapshot);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Container(
              color: Color.fromARGB(255, 10, 184, 239),
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Container baseBody(AsyncSnapshot<QuerySnapshot> snapshot) {
    reportModelList = snapshot.data?.docs;
    var thisWeek = [];
    var todayData = [];
    var thisMonth = [];
    for (int i = 1; i < reportModelList?.length; i++) {
      if (int.parse(reportModelList?[i]['fbusinessDate']) >= int.parse(today)) {
        todayData.add(reportModelList?[i]);
      }
      if (int.parse(reportModelList?[i]['fbusinessDate']) >=
          int.parse(startOfWeek)) {
        if (reportModelList?[i]['time'] == 14) {
          thisWeek.add(reportModelList?[i]);
        }
      }
      if (int.parse(reportModelList?[i]['fbusinessDate']) >=
          int.parse(startOfMonth)) {
        if (reportModelList?[i]['time'] == 14) {
          thisMonth.add(reportModelList?[i]);
        }
      }
    }

    return Container(
      color: const Color.fromARGB(255, 10, 184, 239),
      child: Column(
        children: [
          const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const SizedBox(width: 20),
          //     _dropDate(),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              DateWidget(
                selectedDateRange: selectedDateRange,
                onChanged: (String? value) {
                  setState(() {
                    selectedDateRange = value!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
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
                      getChartData(todayData, thisWeek, thisMonth),
                    ),
                  ),
                )
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
                      getAmtChartData(todayData, thisWeek, thisMonth),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropDate() {
    return Container(
      padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 10, 184, 239),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: selectedDateRange,
        icon: const Icon(Icons.arrow_downward),
        iconEnabledColor: Colors.white,
        elevation: 16,
        underline: Container(),
        style: const TextStyle(color: Colors.orange),
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

  LineChartData getChartData(var todaydata, var thisweek, var thisMonth) {
    print(reportModelList);
    List<FlSpot> creditData = [];
    List<FlSpot> debitData = [];
    List<FlSpot> nonCashData = [];

    var maxXValue = 6.0;
    Widget Function(double, TitleMeta) selectedDate;

    switch (selectedDateRange) {
      case 'Today':
        selectedDate = CustomTitles.bottomTitleHoursWidgets;
        maxXValue = 6.0;
        creditData = [];
        debitData = [];
        nonCashData = [];
        creditData.add(const FlSpot(0, 0.0));
        creditData
            .add(FlSpot(1, double.parse(todaydata?[0]['noCredit']) / 10000));

        debitData.add(const FlSpot(0, 0.0));
        debitData
            .add(FlSpot(1, double.parse(todaydata?[0]['noDebit']) / 10000));

        nonCashData.add(const FlSpot(0, 0.0));
        nonCashData.add(FlSpot(1, double.parse(todaydata?[0]['noTr']) / 10000));

        if (todaydata?.length >= 2) {
          for (int i = 1; i < todaydata?.length; i++) {
            print(todaydata?[i]['fbusinessDate']);
            creditData.add(FlSpot(
                i + 1,
                (double.parse(todaydata?[i]['noCredit']) / 10000) -
                    (double.parse(todaydata?[i - 1]['noCredit']) / 10000)));
          }
          for (int i = 1; i < todaydata?.length; i++) {
            debitData.add(FlSpot(
                i + 1,
                (double.parse(todaydata?[i]['noDebit']) / 10000) -
                    (double.parse(todaydata?[i - 1]['noDebit']) / 10000)));
          }
          for (int i = 1; i < todaydata?.length; i++) {
            nonCashData.add(FlSpot(
                i + 1,
                (double.parse(todaydata?[i]['noTr']) / 10000) -
                    (double.parse(todaydata?[i - 1]['noTr']) / 10000)));
          }
        }

        break;
      case 'This Week':
        selectedDate = CustomTitles.bottomTitleWeekWidgets;
        maxXValue = 6.0;
        creditData.add(const FlSpot(0, 0.0));
        double m = 1.0;
        for (int i = 0; i < thisweek?.length; i++) {
          if (thisweek?[i]['time'] == 14) {
            creditData
                .add(FlSpot(m, double.parse(thisweek?[i]['noCredit']) / 10000));
            m += 1;
          }
        }

        debitData.add(const FlSpot(0, 0.0));
        double k = 1.0;
        for (int i = 0; i < thisweek?.length; i++) {
          if (thisweek?[i]['time'] == 14) {
            debitData
                .add(FlSpot(k, double.parse(thisweek?[i]['noDebit']) / 10000));
            k += 1;
          }
        }

        nonCashData.add(const FlSpot(0, 0.0));
        double j = 1.0;
        for (int i = 0; i < thisweek?.length; i++) {
          if (thisweek?[i]['time'] == 14) {
            nonCashData
                .add(FlSpot(j, double.parse(thisweek?[i]['noTr']) / 10000));
            j += 1;
          }
        }
        break;
      case 'This Month':
        selectedDate = CustomTitles.bottomTitleMonthWidgets;
        maxXValue = 4.0;
        creditData.add(const FlSpot(0, 0.0));
        debitData.add(const FlSpot(0, 0.0));
        nonCashData.add(const FlSpot(0, 0.0));
        double m = 1.0;
        int days = 0;
        double avgCr = 0;
        double avgDr = 0;
        double avgNonCash = 0;
        for (int i = 0; i < thisMonth?.length; i++) {
          if (thisMonth?[i]['time'] == 14) {
            if (days < 6) {
              avgCr += double.parse(thisMonth?[i]['noCredit']) / 10000;
              avgDr += double.parse(thisMonth?[i]['noDebit']) / 10000;
              avgNonCash += double.parse(thisMonth?[i]['noTr']) / 10000;
              days += 1;
            } else {
              print(avgCr);
              creditData.add(FlSpot(m, avgCr / days));
              debitData.add(FlSpot(m, avgDr / days));
              nonCashData.add(FlSpot(m, avgNonCash / days));
              m += 1;
              avgCr = 0;
              avgDr = 0;
              avgNonCash = 0;
              days = 0;
            }
          }
        }
        // creditData.add(FlSpot(m, avgCr / days));
        // debitData.add(FlSpot(m, avgDr / days));
        // nonCashData.add(FlSpot(m, avgNonCash / days));
        break;
      default:
        selectedDate = CustomTitles.bottomTitleHoursWidgets;
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
        selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
        break;
      case 'Non-Cash':
        selectedData = nonCashData;
        selectedSideTitle = CustomTitles.leftTitleNonCashAmtWidgets;
        break;
      default:
        selectedData = [];
        selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
    }

    return LineChartData(
      lineTouchData: const LineTouchData(enabled: true),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: false,
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
                  .lerp(0.1)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.1)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.5),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.5),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LineChartData getAmtChartData(var todaydata, var thisweek, var thisMonth) {
    List<FlSpot> creditAmtData = [];
    List<FlSpot> debitAmtData = [];
    List<FlSpot> nonCashAmtData = [];

    var maxXValue = 6.0;
    Widget Function(double, TitleMeta) selectedDate;

    switch (selectedDateRange) {
      case 'Today':
        selectedDate = CustomTitles.bottomTitleHoursWidgets;
        maxXValue = 6.0;
        creditAmtData.add(const FlSpot(0, 0.0));
        creditAmtData.add(
            FlSpot(1, double.parse(todaydata?[0]['ttlCrAmt']) / 100000000));
        for (int i = 1; i < todaydata?.length; i++) {
          creditAmtData.add(FlSpot(
              i + 1,
              (double.parse(todaydata?[i]['ttlCrAmt']) / 100000000) -
                  (double.parse(todaydata?[i - 1]['ttlCrAmt']) / 100000000)));
        }

        debitAmtData.add(const FlSpot(0, 0.0));
        debitAmtData.add(
            FlSpot(1, double.parse(todaydata?[0]['ttlDrAmt']) / 100000000));
        for (int i = 1; i < todaydata?.length; i++) {
          debitAmtData.add(FlSpot(
              i + 1,
              (double.parse(todaydata?[i]['ttlDrAmt']) / 100000000) -
                  (double.parse(todaydata?[i - 1]['ttlDrAmt']) / 100000000)));
        }

        nonCashAmtData.add(const FlSpot(0, 0.0));
        nonCashAmtData.add(
            FlSpot(1, double.parse(todaydata?[0]['ttlAmount']) / 1000000000));
        for (int i = 1; i < todaydata?.length; i++) {
          nonCashAmtData.add(FlSpot(
              i + 1,
              (double.parse(todaydata?[i]['ttlAmount']) / 1000000000) -
                  (double.parse(todaydata?[i - 1]['ttlAmount']) / 1000000000)));
        }
        break;
      case 'This Week':
        selectedDate = CustomTitles.bottomTitleWeekWidgets;
        maxXValue = 6.0;
        creditAmtData.add(const FlSpot(0, 0.0));
        double m = 1.0;
        for (int i = 0; i < thisweek?.length; i++) {
          if (thisweek?[i]['time'] == 14) {
            creditAmtData.add(
                FlSpot(m, double.parse(thisweek?[i]['ttlCrAmt']) / 100000000));
            m += 1;
          }
        }

        debitAmtData.add(const FlSpot(0, 0.0));
        double k = 1.0;
        for (int i = 0; i < thisweek?.length; i++) {
          if (thisweek?[i]['time'] == 14) {
            debitAmtData.add(
                FlSpot(k, double.parse(thisweek?[i]['ttlDrAmt']) / 100000000));
            k += 1;
          }
        }

        nonCashAmtData.add(const FlSpot(0, 0.0));
        double j = 1.0;
        for (int i = 0; i < thisweek?.length; i++) {
          if (thisweek?[i]['time'] == 14) {
            nonCashAmtData.add(FlSpot(
                j, double.parse(thisweek?[i]['ttlAmount']) / 1000000000));
            j += 1;
          }
        }
        break;
      case 'This Month':
        selectedDate = CustomTitles.bottomTitleMonthWidgets;
        maxXValue = 4.0;
        creditAmtData.add(const FlSpot(0, 0.0));
        debitAmtData.add(const FlSpot(0, 0.0));
        nonCashAmtData.add(const FlSpot(0, 0.0));
        double m = 1.0;
        int days = 0;
        double avgCr = 0;
        double avgDr = 0;
        double avgNonCash = 0;
        for (int i = 0; i < thisMonth?.length; i++) {
          if (thisMonth?[i]['time'] == 14) {
            if (days < 6) {
              avgCr += double.parse(thisMonth?[i]['ttlCrAmt']) / 100000000;
              avgDr += double.parse(thisMonth?[i]['ttlDrAmt']) / 100000000;
              avgNonCash +=
                  double.parse(thisMonth?[i]['ttlAmount']) / 1000000000;
              days += 1;
            } else {
              creditAmtData.add(FlSpot(m, avgCr / days));
              debitAmtData.add(FlSpot(m, avgDr / days));
              nonCashAmtData.add(FlSpot(m, avgNonCash / days));
              m += 1;
              avgCr = 0;
              avgDr = 0;
              avgNonCash = 0;
              days = 0;
            }
          }
        }
        // creditAmtData.add(FlSpot(m, avgCr / days));
        // debitAmtData.add(FlSpot(m, avgDr / days));
        // nonCashAmtData.add(FlSpot(m, avgNonCash / days));
        break;
      default:
        selectedDate = CustomTitles.bottomTitleHoursWidgets;
    }
    List<FlSpot> selectedData;
    var labelMeasure = "TR Amount per 100M";
    Widget Function(double, TitleMeta) selectedSideTitle;

    switch (selectedTransactionType) {
      case 'Credit':
        selectedData = creditAmtData;
        selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
        labelMeasure = "TR Amount per 100M";
        break;
      case 'Debit':
        selectedData = debitAmtData;
        selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
        labelMeasure = "TR Amount per 100M";
        break;
      case 'Non-Cash':
        selectedData = nonCashAmtData;
        selectedSideTitle = CustomTitles.leftTitleNonCashAmtWidgets;
        labelMeasure = "TR Amount per billion";
        break;
      default:
        selectedData = [];
        selectedSideTitle = CustomTitles.leftTitleCashAmtWidgets;
    }

    return LineChartData(
      lineTouchData: const LineTouchData(enabled: true),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: false,
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
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.5),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.5),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
