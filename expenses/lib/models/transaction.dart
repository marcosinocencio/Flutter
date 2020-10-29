import 'package:flutter/foundation.dart';

class Transaction {
  final String id, title;
  final double value;
  final DateTime date;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.value,
      @required this.date});
}
