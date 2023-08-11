import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:people_manager/widgets/person_provider.dart';
import 'package:people_manager/widgets/person_form.dart';

import 'package:people_manager/entities/person.dart';

class CreatePersonPage extends StatelessWidget {
  const CreatePersonPage({this.person, super.key});

  final Person? person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(person != null
            ? "Atualizar dados de pessoa"
            : "Adicionar nova pessoa"),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) {
            return PersonProvider(person);
          },
          builder: (context, child) => const PersonForm(),
        ),
      ),
    );
  }
}
