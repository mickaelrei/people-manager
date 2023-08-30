import 'package:flutter/material.dart';

import 'package:people_manager/entities/blood_type.dart';
import 'package:people_manager/entities/person.dart';

class PeopleListProvider with ChangeNotifier {
  PeopleListProvider() {
    // Atualiza a lista filtrada toda vez que mudar o texto de pesquisa
    _searchController.addListener(updateFilteredList);
  }

  // Caixa de texto de pesquisa
  final TextEditingController _searchController = TextEditingController();

  // Informação sobre pesquisa
  FilterType _filterType = FilterType.name;
  BloodType _bloodTypeSearch = BloodType.aPositive;

  // Lista de pessoas
  final _items = <Person>[];
  final _filteredItems = <Person>[];

  TextEditingController get searchController => _searchController;
  List<Person> get items => List.unmodifiable(_items);
  List<Person> get filteredItems => List.unmodifiable(_filteredItems);

  // Getter e setter pra pesquisa por tipo sanguíneo
  BloodType get bloodTypeSearch => _bloodTypeSearch;
  set bloodTypeSearch(BloodType type) {
    _bloodTypeSearch = type;
    updateFilteredList();
  }

  // Getter e setter pra modificar tipo de filtro
  FilterType get filterType => _filterType;
  set filterType(FilterType type) {
    if (type == FilterType.bloodType) {
      searchController.text = "";
    }
    _filterType = type;
    updateFilteredList();
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  void add(Person person) {
    _items.add(person);

    // Verifica se a pessoa deve entrar na lista de filtrados
    if (fitsFilter(person)) {
      _filteredItems.add(person);
    }

    // Atualiza tela
    notifyListeners();
  }

  void delete(Person person) {
    // Remove de ambas as listas
    _items.remove(person);
    _filteredItems.remove(person);

    // Atualiza tela
    notifyListeners();
  }

  String? edit(Person person,
      {String? name,
      String? email,
      String? number,
      String? github,
      BloodType? bloodType}) {
    // Verifica se a pessoa existe na lista
    final index = _items.indexOf(person);
    if (index == -1) {
      return "Pessoa não consta na lista";
    }

    // Atualiza campos se houve mudança
    bool updated = false;
    if (name != null && _items[index].name != name) {
      _items[index].name = name;
      updated = true;
    }
    if (email != null && _items[index].email != email) {
      _items[index].email = email;
      updated = true;
    }
    if (number != null && _items[index].number != number) {
      _items[index].number = number;
      updated = true;
    }
    if (github != null && _items[index].github != github) {
      _items[index].github = github;
      updated = true;
    }
    if (bloodType != null && _items[index].bloodType != bloodType) {
      _items[index].bloodType = bloodType;
      updated = true;
    }

    if (updated) {
      // Notifica mudanças para modificar as informações na tela de listagem
      notifyListeners();
      return null;
    }

    // Se não houve mudança, não fazer nada
    return "Não houve mudanças nas informações da pessoa";
  }

  bool fitsFilter(Person person) {
    switch (_filterType) {
      case FilterType.name:
        // Verifica se o name contém a pesquisa
        return (person.name.withoutDiacritics
            .toLowerCase()
            .contains(searchController.text));
      case FilterType.email:
        // Verifica se o email contém a pesquisa
        return (person.email.withoutDiacritics
            .toLowerCase()
            .contains(searchController.text));
      case FilterType.number:
        // Verifica se o number contém a pesquisa
        return (person.number.withoutDiacritics
            .toLowerCase()
            .contains(searchController.text));
      case FilterType.github:
        // Verifica se o github contém a pesquisa
        return (person.github.withoutDiacritics
            .toLowerCase()
            .contains(searchController.text));
      case FilterType.bloodType:
        // Verifica se o tipo sanguineo é o mesmo
        return (person.bloodType == bloodTypeSearch);
    }
  }

  void updateFilteredList() {
    // Se for uma pesquisa vazia, a lista filtrada vira a lista inteira
    if (filterType != FilterType.bloodType && searchController.text == "") {
      _filteredItems.clear();
      _filteredItems.addAll(_items);
      notifyListeners();
      return;
    }

    // Limpa a lista filtrada
    _filteredItems.clear();

    for (final person in _items) {
      if (fitsFilter(person)) {
        _filteredItems.add(person);
      }
    }

    // Atualizar tela
    notifyListeners();
  }
}

enum FilterType { name, email, number, github, bloodType }
