import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomTitles {
  static Widget bottomTitleWeekWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('MON', style: style);
        break;
      case 2:
        text = const Text('THU', style: style);
        break;
      case 3:
        text = const Text('WED', style: style);
        break;
      case 4:
        text = const Text('THU', style: style);
        break;
      case 5:
        text = const Text('FRI', style: style);
        break;
      case 6:
        text = const Text('SAT', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  static Widget bottomTitleMonthWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('1', style: style);
        break;
      case 2:
        text = const Text('', style: style);
        break;
      case 3:
        text = const Text('', style: style);
        break;
      case 4:
        text = const Text('', style: style);
        break;
      case 5:
        text = const Text('5', style: style);
        break;
      case 6:
        text = const Text('', style: style);
        break;
      case 7:
        text = const Text('', style: style);
        break;
      case 8:
        text = const Text('', style: style);
        break;
      case 9:
        text = const Text('', style: style);
        break;
      case 10:
        text = const Text('10', style: style);
        break;
      case 11:
        text = const Text('', style: style);
        break;
      case 12:
        text = const Text('', style: style);
        break;
      case 13:
        text = const Text('', style: style);
        break;
      case 14:
        text = const Text('', style: style);
        break;
      case 15:
        text = const Text('15', style: style);
        break;
      case 16:
        text = const Text('1', style: style);
        break;
      case 17:
        text = const Text('', style: style);
        break;
      case 18:
        text = const Text('', style: style);
        break;
      case 19:
        text = const Text('', style: style);
        break;
      case 20:
        text = const Text('20', style: style);
        break;
      case 21:
        text = const Text('', style: style);
        break;
      case 22:
        text = const Text('', style: style);
        break;
      case 23:
        text = const Text('', style: style);
        break;
      case 24:
        text = const Text('', style: style);
        break;
      case 25:
        text = const Text('25', style: style);
        break;
      case 26:
        text = const Text('', style: style);
        break;
      case 27:
        text = const Text('', style: style);
        break;
      case 28:
        text = const Text('', style: style);
        break;
      case 29:
        text = const Text('', style: style);
        break;
      case 30:
        text = const Text('', style: style);
        break;
      case 31:
        text = const Text('31', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  static Widget bottomTitleHoursWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('10:00', style: style);
        break;
      case 2:
        text = const Text('12:00', style: style);
        break;
      case 3:
        text = const Text('2:00', style: style);
        break;
      case 4:
        text = const Text('4:00', style: style);
        break;
      case 5:
        text = const Text('6:00', style: style);
        break;
      case 6:
        text = const Text('8:00', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  static Widget leftTitleNumWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1';
        break;
      case 2:
        text = '';
        break;
      case 3:
        text = '3';
        break;
      case 4:
        text = '';
        break;
      case 5:
        text = '5';
        break;
      case 6:
        text = '';
        break;
      case 7:
        text = '7';
        break;
      case 8:
        text = '';
        break;
      case 9:
        text = '9';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  static Widget leftTitleNonCashAmtWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1';
        break;
      case 2:
        text = '';
        break;
      case 3:
        text = '3';
        break;
      case 4:
        text = '';
        break;
      case 5:
        text = '5';
        break;
      case 6:
        text = '';
        break;
      case 7:
        text = '7';
        break;
      case 8:
        text = '';
        break;
      case 9:
        text = '9';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  static Widget leftTitleCashAmtWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1';
        break;
      case 2:
        text = '';
        break;
      case 3:
        text = '3';
        break;
      case 4:
        text = '';
        break;
      case 5:
        text = '5';
        break;
      case 6:
        text = '';
        break;
      case 7:
        text = '7';
        break;
      case 8:
        text = '';
        break;
      case 9:
        text = '9';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
