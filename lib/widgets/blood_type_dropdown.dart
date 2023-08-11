import 'package:flutter/material.dart';

import 'package:people_manager/entities/blood_type.dart';

class BloodTypeDropdown extends StatelessWidget {
  const BloodTypeDropdown(
      {required this.onChanged, this.initialValue, super.key});

  final BloodType? initialValue;
  final void Function(BloodType?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<BloodType>(
        value: initialValue,
        isExpanded: true,
        hint: const Text("Tipo Sanguíneo"),
        elevation: 6,
        onChanged: onChanged,
        items: const [
          DropdownMenuItem<BloodType>(
            value: BloodType.aNegative,
            child: Text("A-"),
          ),
          DropdownMenuItem<BloodType>(
            value: BloodType.aPositive,
            child: Text("A+"),
          ),
          DropdownMenuItem<BloodType>(
            value: BloodType.bPositive,
            child: Text("B+"),
          ),
          DropdownMenuItem<BloodType>(
            value: BloodType.bNegative,
            child: Text("B-"),
          ),
          DropdownMenuItem<BloodType>(
            value: BloodType.oPositive,
            child: Text("O+"),
          ),
          DropdownMenuItem<BloodType>(
            value: BloodType.oNegative,
            child: Text("O-"),
          ),
          DropdownMenuItem<BloodType>(
            value: BloodType.abPositive,
            child: Text("AB+"),
          ),
          DropdownMenuItem<BloodType>(
            value: BloodType.abNegative,
            child: Text("AB-"),
          ),
        ],
      ),
    );
  }
}
