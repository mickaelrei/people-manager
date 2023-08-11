import 'package:flutter/material.dart';

import 'package:people_manager/entities/person.dart';
import 'package:people_manager/widgets/people_list_provider.dart';
import 'package:provider/provider.dart';

class PersonPopupButton extends StatelessWidget {
  const PersonPopupButton(
      {required this.onRemove, required this.person, super.key});

  final void Function() onRemove;
  final Person person;

  @override
  Widget build(BuildContext context) {
    final peopleList = Provider.of<PeopleListProvider>(context, listen: false);

    return PopupMenuButton<String>(
      // O widget PopupMenuButton faz um Navigator.pop() automático quando
      // um valor é selecionado, então pra poder chamar outra rota é preciso
      // usar o onSelected, que ocorre após o Navigator.pop() do PopupMenuButton
      onSelected: (String? selected) async {
        if (selected != "Edit") return;

        // Entra na rota create e espera a informação
        final personData = await Navigator.of(context)
            .pushNamed("/create", arguments: person) as Map<String, dynamic>;

        // Decide se vai adicionar ou editar uma pessoa
        late String dialogText;
        late String? result;
        if (personData["person"] != null) {
          print("Editing");
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
      tooltip: "Opções",
      itemBuilder: (context) {
        return [
          // Botão de editar
          const PopupMenuItem<String>(
            value: "Edit",
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.blue),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Editar"),
                ),
              ],
            ),
          ),

          // Botão de remover
          PopupMenuItem<String>(
            value: "Remove",
            onTap: onRemove,
            child: const Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Remover"),
                )
              ],
            ),
          )
        ];
      },
    );
  }
}
