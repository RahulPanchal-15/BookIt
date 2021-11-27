import 'package:flutter/material.dart';

selectDate(
  BuildContext context,
  DateTime? nextDate,
) async {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  DateTime date =
      nextDate == null ? DateTime.now().add(Duration(days: 1)) : nextDate;
  final DateTime? selected = await showDatePicker(
    context: context,
    initialDate: DateTime(currentYear, currentMonth, date.day),
    firstDate: DateTime(currentYear, currentMonth, date.day),
    lastDate: DateTime(currentYear + 1, currentMonth, date.day),
  );
  if (selected != null && selected != nextDate) return selected;
}
