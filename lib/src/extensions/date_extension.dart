import 'package:flutter/material.dart';
import 'time_extension.dart';

extension DateUtils on DateTime {
  static final Map<int, String> _months = {
    1: "Jan",
    2: "Fev",
    3: "Mar",
    4: "Abr",
    5: "Mai",
    6: "Jun",
    7: "Jul",
    8: "Ago",
    9: "Set",
    10: "Out",
    11: "Nov",
    12: "Dez",
  };

  // static final Map<int, String> _fullmonths = {
  //   1: "January",
  //   2: "February",
  //   3: "March",
  //   4: "April",
  //   5: "May",
  //   6: "June",
  //   7: "July",
  //   8: "August",
  //   9: "September",
  //   10: "October",
  //   11: "November",
  //   12: "December",
  // };

  String get stringify => "$year-$month-$day";

  String get excludeYear => "$month/$day";

  String get dayFormat {
    var m = _months[month];
    return '$day $m';
  }

  String get namedFormat {
    var m = _months[month];
    return "$day $m, $year";
  }

  static final Map<int, String> _weekDay = {
    1: 'Seg',
    2: 'Ter',
    3: 'Qua',
    4: 'Qui',
    5: 'Sex',
    6: 'Sab',
    7: 'Dom'
  };
  static final Map<int, String> _weekDayFull = {
    1: 'Segunda',
    2: 'Terça',
    3: 'Quarta',
    4: 'Quinta',
    5: 'Sexta',
    6: 'Sábado',
    7: 'Domingo'
  };

  String get weekFormat => _weekDayFull[weekday] ?? '';
  String get weekFormatCut => _weekDay[weekday] ?? '';

  String get formatted {
    var date = this;
    return "${_weekDay[date.weekday]}, ${_months[date.month]} ${date.day}";
  }

  String get msgFormat {
    TimeOfDay cur = TimeOfDay.fromDateTime(this);
    if (DateTime.now().difference(this).inDays == 0) {
      return cur.stringify;
    }
    return '${_weekDay[weekday]} @ ${cur.stringify}';
  }
}
