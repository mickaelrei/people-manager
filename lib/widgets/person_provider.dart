import 'package:flutter/material.dart';

import 'package:people_manager/entities/blood_type.dart';
import 'package:people_manager/entities/person.dart';

class PersonProvider with ChangeNotifier {
  PersonProvider(this.person) {
    // Inicia valores de pessoa existente ou valores "zerados"
    nameController.text = person?.name ?? "";
    emailController.text = person?.email ?? "";
    numberController.text = person?.number ?? "";
    githubController.text = person?.github ?? "";
    bloodType = person?.bloodType ?? BloodType.aPositive;
  }

  // Campos que podem mudar
  late BloodType bloodType;

  // Controllers de texto
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController githubController = TextEditingController();

  // Campo pessoa que, quando nulo, significa criar novo, e não nulo significa
  // editar existente
  final Person? person;

  // Chave do formulario
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    emailController.dispose();
    numberController.dispose();
    githubController.dispose();
  }
}
