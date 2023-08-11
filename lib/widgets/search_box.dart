import 'package:flutter/material.dart';

import 'package:people_manager/widgets/people_list_provider.dart';

class SearchBox extends StatelessWidget {
  const SearchBox(
      {required this.controller, required this.filterType, super.key});

  final FilterType filterType;
  final TextEditingController controller;

  //pesquisa is BloodType ? pesquisa : null,

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Pesquisa",
          hintText: "Pesquisa",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
