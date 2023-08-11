import 'package:flutter/material.dart';

import 'package:people_manager/entities/blood_type.dart';
import 'package:people_manager/entities/person.dart';

import 'package:people_manager/widgets/person_popup_button.dart';

class PersonTile extends StatelessWidget {
  const PersonTile({required this.onRemove, required this.person, super.key});

  final Person person;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    final Color bloodTypeColor = bloodTypeToColor(person.bloodType);

    return ListTile(
      minVerticalPadding: 15,

      // Informações
      title: Text(person.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            person.email,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            person.number,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            person.github,
            overflow: TextOverflow.ellipsis,
          ),
        ]
            .map((widget) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: widget))
            .toList(),
      ),

      // Tipo sanguíneo
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bloodTypeColor,
        ),
        child: Center(
          child: Text(
            bloodTypeToString(person.bloodType),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: bloodTypeColor.computeLuminance() > .5
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),

      // Menu de ações
      trailing: PersonPopupButton(
        person: person,
        onRemove: onRemove,
      ),
    );
  }
}
