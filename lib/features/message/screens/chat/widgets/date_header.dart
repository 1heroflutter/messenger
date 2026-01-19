
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String label = "";
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      label = "TODAY";
    } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
      label = "YESTERDAY";
    } else {
      label = DateFormat('MMM dd, yyyy').format(date).toUpperCase();
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
