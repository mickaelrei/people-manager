import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:people_manager/entities/person.dart';

import 'package:people_manager/widgets/people_list_provider.dart';

class CreatePersonButton extends StatelessWidget {
  const CreatePersonButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PeopleListProvider>(
      builder: (context, peopleList, child) => FloatingActionButton(
        backgroundColor: Colors.green,
        elevation: 5,
        onPressed: () async {
          // Entra na rota create e espera a informação
          final personData = await Navigator.of(context).pushNamed("/create")
              as Map<String, dynamic>;

          // Decide se vai adicionar ou editar uma pessoa
          late String dialogText;
          late String? result;
          if (personData["person"] != null) {
            result = peopleList.edit(
              personData["person"],
              name: personData["name"],
              email: personData["email"],
              number: personData["number"],
              github: personData["github"],
              bloodType: personData["bloodType"],
            );

            // Tela de edição
            dialogText = result ??
                "As informações da pessoa "
                    "foram atualizados com sucesso!";
          } else {
            peopleList.add(Person(
              name: personData["name"],
              number: personData["number"],
              email: personData["email"],
              github: personData["github"],
              bloodType: personData["bloodType"],
            ));

            // Tela de criação
            result = null;
            dialogText = "Pessoa incluída com sucesso!";
          }

          // Mostra diálogo após criação da pessoa
          Widget okButton = TextButton(
            onPressed: () {
              // Pop para sair da tela de diálogo
              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          );

          // Informa ao usuário que foi atualizado
          // ignore: use_build_context_synchronously
          showDialog(
            useRootNavigator: false,
            context: context,
            builder: (context) => AlertDialog(
              title: Text(result == null ? "Sucesso" : "Erro"),
              content: Text(dialogText),
              actions: [okButton],
            ),
          );

          // Atualiza filtros
          peopleList.updateFilteredList();
        },
        child: const Icon(Icons.add, size: 35, color: Colors.white),
      ),
    );
  }
}
