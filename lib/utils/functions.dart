import 'dart:math';
import 'dart:developer' as logCheck;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String getRandomNumbericString({required int length}) {
  const _chars = '1234567890';
  final Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

String formatTimestamp(Timestamp timestamp) {
  var format = DateFormat('d-MM-y, hh:mm a'); // <- use skeleton here
  return format.format(timestamp.toDate());
}
