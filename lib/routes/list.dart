import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:people_manager/entities/blood_type.dart';

import 'package:people_manager/widgets/create_person_button.dart';
import 'package:people_manager/widgets/blood_type_dropdown.dart';
import 'package:people_manager/widgets/filter_type_dropdown.dart';
import 'package:people_manager/widgets/person_tile.dart';
import 'package:people_manager/widgets/search_box.dart';
import 'package:people_manager/widgets/people_list_provider.dart';

class PeopleListingPage extends StatelessWidget {
  const PeopleListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listagem de pessoas")),

      // Botão de incluir pessoa
      floatingActionButton: const CreatePersonButton(),

      body: Consumer<PeopleListProvider>(
        builder: (context, peopleList, child) => Column(
          children: [
            // Linha contendo tipo de filtro
            Row(
              children: [
                // Texto
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Filtrar por:", style: TextStyle(fontSize: 17)),
                ),

                // Tipo de filtro
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 8,
                    ),
                    child: FilterTypeDropdown(
                      initialValue: peopleList.filterType,
                      onChanged: (FilterType? value) {
                        peopleList.filterType = value!;
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Menu de busca
            // Caso estiver filtrando por tipo sanguíneo, mostrar um dropdown
            if (peopleList.filterType == FilterType.bloodType)
              BloodTypeDropdown(
                initialValue: peopleList.bloodTypeSearch,
                onChanged: (BloodType? type) {
                  peopleList.updateFilteredList();
                  peopleList.bloodTypeSearch = type!;
                },
              )
            // Caso estiver filtrando por outra coisa, mostrar uma caixa
            // de texto
            else
              SearchBox(
                controller: peopleList.searchController,
                filterType: peopleList.filterType,
              ),

            // Listagem das pessoas
            Expanded(
              child: ListView.builder(
                itemCount: peopleList.filteredItems.length,
                itemBuilder: (context, index) {
                  // Objeto pessoa
                  final person = peopleList.filteredItems[index];

                  return PersonTile(
                    person: person,
                    onRemove: () => peopleList.delete(person),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
