import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:people_manager/entities/blood_type.dart';

import 'package:people_manager/widgets/person_provider.dart';

// Regex de email
final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
    r"[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

class PersonForm extends StatelessWidget {
  const PersonForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonProvider>(
      builder: (context, createPerson, child) => Form(
        key: createPerson.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo nome
              TextFormField(
                controller: createPerson.nameController,
                // initialValue: createPerson.name,
                // onChanged: (value) => nome = value,
                decoration: const InputDecoration(
                  labelText: "Nome",
                ),
                validator: (String? value) {
                  if (value == null ||
                      value.length < 3 ||
                      value[0].toUpperCase() != value[0]) {
                    return "Precisa ter ao menos 3 letras,"
                        " sendo a primeira maiúscula";
                  }

                  return null;
                },
              ),

              // Campo email
              TextFormField(
                controller: createPerson.emailController,
                // initialValue: email,
                // onChanged: (value) => email = value,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                validator: (String? value) {
                  if (value == null || !emailRegex.hasMatch(value)) {
                    return "Precisa ser um email válido";
                  }

                  return null;
                },
              ),

              // Campo telefone
              TextFormField(
                controller: createPerson.numberController,
                // initialValue: telefone,
                // onChanged: (value) => telefone = value,
                decoration: const InputDecoration(
                  labelText: "Telefone",
                ),
                validator: (String? value) {
                  if (value == null || value.length != 9) {
                    return "Precisa ser um número no formato xxxx-xxxx";
                  }

                  // Verifica se é válido
                  for (int i = 0; i < 4; i++) {
                    if (int.tryParse(value[i]) == null) {
                      return "Precisa ser um número no formato xxxx-xxxx";
                    }
                  }
                  for (int i = 5; i < 9; i++) {
                    if (int.tryParse(value[i]) == null) {
                      return "Precisa ser um número no formato xxxx-xxxx";
                    }
                  }

                  return null;
                },
              ),

              // Campo github
              TextFormField(
                controller: createPerson.githubController,
                // initialValue: github,
                // onChanged: (value) => github = value,
                decoration: const InputDecoration(
                  labelText: "GitHub",
                ),
                validator: (String? value) {
                  if (value == null || value == "") {
                    return "Precisa um nome/link váido do GitHub";
                  }

                  return null;
                },
              ),

              // Campo tipo sanguineo
              DropdownButtonFormField<BloodType>(
                validator: (tipo) =>
                    tipo == null ? "Selecione o tipo sanguíneo" : null,
                onChanged: (bloodType) {
                  createPerson.bloodType = bloodType!;
                },
                isExpanded: true,
                value: createPerson.bloodType,
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

              // Botão de enviar
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (!createPerson.formKey.currentState!.validate()) return;

                    /*
                    // Se o campo person não é null, então é para editar
                    String? resultado;
                    if (createPerson.person != null) {
                      // Envia informações para editar
                      resultado = Provider.of<EstadoListaDePessoas>(context,
                              listen: false)
                          .editar(
                        widget.person!,
                        nome: nome,
                        email: email,
                        telefone: telefone,
                        github: github,
                        BloodType: BloodType,
                      );
                    } else {
                      // Envia informações para incluir
                      Provider.of<EstadoListaDePessoas>(context, listen: false)
                          .incluir(Pessoa(
                        nome: nome,
                        email: email,
                        telefone: telefone,
                        github: github,
                        BloodType: BloodType!,
                      ));
                    }
                    */

                    // Caso os campos tenham valores válidos, retornar à rota
                    // anterior passando a pessoa como argumento
                    print("Popping");
                    Navigator.of(context).pop({
                      "person": createPerson.person,
                      "name": createPerson.nameController.text,
                      "email": createPerson.emailController.text,
                      "number": createPerson.numberController.text,
                      "github": createPerson.githubController.text,
                      "bloodType": createPerson.bloodType,
                    });
                  },
                  child: Text(
                    createPerson.person != null ? 'Editar' : 'Incluir',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
