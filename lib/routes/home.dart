import 'package:flutter/material.dart';

import 'package:people_manager/widgets/create_person_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gerenciador de pessoas")),

      // Botão de incluir pessoa
      floatingActionButton: const CreatePersonButton(),

      // Corpo da página
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 100),
            const Text(
              "Aplicativo de gerenciamento de pessoas",
              style: TextStyle(fontSize: 17),
            ),
            ElevatedButton.icon(
              label: const Text("Listar"),
              icon: const Icon(Icons.list),
              onPressed: () => Navigator.of(context).pushNamed("/list"),
            )
          ],
        ),
      ),
    );
  }
}
