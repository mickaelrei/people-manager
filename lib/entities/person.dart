import 'dart:math';
import 'package:people_manager/entities/blood_type.dart';

class Person {
  Person(
      {required this.name,
      required this.number,
      required this.email,
      required this.github,
      required this.bloodType});

  String name;
  String number;
  String email;
  String github;
  BloodType bloodType;

  @override
  int get hashCode => Object.hash(name, email, number, github, BloodType);

  // Checa por igualdade
  @override
  bool operator ==(Object other) {
    return other is Person &&
        name == other.name &&
        email == other.email &&
        number == other.number &&
        github == other.github &&
        bloodType == other.bloodType;
  }

  @override
  String toString() {
    return "Name: $name, Email: $email, Number: $number, GitHub: $github, Tipo Sangue: ${bloodTypeToString(bloodType)}";
  }
}

// Usado para gerar uma pessoa aleatória (para fim de testes)
const names = <String>[
  "João",
  "Maria",
  "Estevão",
  "Roberto",
  "Antônio",
  "Joana",
  "Gabriel",
  "Jonathan",
  "Felipe",
  "Matheus",
  "Guilherme",
  "Igor",
  "Larissa",
  "Sofia",
  "Eliana"
];

const surnames = <String>[
  "Souza",
  "Soares",
  "Neto",
  "Nascimento",
  "Pires",
  "Santos",
  "Padia",
  "Correa",
  "Schneider",
  "Pereira",
  "Reiter",
  "França"
];

Person newRandomPerson() {
  final random = Random();
  final name = names[random.nextInt(names.length)];
  final surname = surnames[random.nextInt(surnames.length)];
  final number =
      "${random.nextInt(9001) + 1000}-${random.nextInt(9001) + 1000}";

  final nameReduced = name.withoutDiacritics.toLowerCase();
  final surnameReduced = surname.withoutDiacritics.toLowerCase();

  return Person(
      name: "$name $surname",
      email: "${nameReduced}_"
          "$surnameReduced@gmail.com",
      number: number,
      github: "https://github.com/${nameReduced}_$surnameReduced",
      bloodType: BloodType.values[random.nextInt(BloodType.values.length)]);
}

// Remover acentos (diacritics em inglês)
// https://stackoverflow.com/questions/30844353/how-to-remove-diacritics-accents-from-a-string
extension RemoveDiacritics on String {
  static const diacritics =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  static const nonDiacritics =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  String get withoutDiacritics {
    String str = this;
    for (int i = 0; i < diacritics.length; i++) {
      str = str.replaceAll(diacritics[i], nonDiacritics[i]);
    }

    return str;
  }
}
