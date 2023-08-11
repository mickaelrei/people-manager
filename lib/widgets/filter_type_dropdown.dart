import 'package:flutter/material.dart';

import 'package:people_manager/widgets/people_list_provider.dart';

class FilterTypeDropdown extends StatelessWidget {
  const FilterTypeDropdown(
      {required this.onChanged, this.initialValue, super.key});

  final FilterType? initialValue;
  final void Function(FilterType?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<FilterType>(
      isExpanded: true,
      value: initialValue,
      hint: const Text("Filtrar por:"),
      elevation: 6,
      onChanged: onChanged,
      items: const [
        DropdownMenuItem<FilterType>(
          value: FilterType.name,
          child: Text("Nome"),
        ),
        DropdownMenuItem<FilterType>(
          value: FilterType.email,
          child: Text("Email"),
        ),
        DropdownMenuItem<FilterType>(
          value: FilterType.number,
          child: Text("Telefone"),
        ),
        DropdownMenuItem<FilterType>(
          value: FilterType.github,
          child: Text("GitHub"),
        ),
        DropdownMenuItem<FilterType>(
          value: FilterType.bloodType,
          child: Text("Tipo Sanguíneo"),
        ),
      ],
    );
  }
}
