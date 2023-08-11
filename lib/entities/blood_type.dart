import 'package:flutter/material.dart';

enum BloodType {
  aPositive,
  aNegative,
  bPositive,
  bNegative,
  oPositive,
  oNegative,
  abPositive,
  abNegative
}

String bloodTypeToString(BloodType type) {
  switch (type) {
    case BloodType.aPositive:
      return "A+";
    case BloodType.aNegative:
      return "A-";
    case BloodType.bPositive:
      return "B+";
    case BloodType.bNegative:
      return "B-";
    case BloodType.oPositive:
      return "O+";
    case BloodType.oNegative:
      return "O-";
    case BloodType.abPositive:
      return "AB+";
    case BloodType.abNegative:
      return "AB-";
  }
}

Color bloodTypeToColor(BloodType type) {
  switch (type) {
    case BloodType.aPositive:
      return Colors.blue;
    case BloodType.aNegative:
      return Colors.red;
    case BloodType.bPositive:
      return Colors.purple;
    case BloodType.bNegative:
      return Colors.orange;
    case BloodType.oPositive:
      return Colors.green;
    case BloodType.oNegative:
      return Colors.yellow;
    case BloodType.abPositive:
      return Colors.cyan;
    case BloodType.abNegative:
      return Colors.white;
  }
}
