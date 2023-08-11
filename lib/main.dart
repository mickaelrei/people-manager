import 'package:flutter/material.dart';

import 'package:people_manager/entities/person.dart';
import 'package:people_manager/routes/create.dart';

import 'package:people_manager/routes/home.dart';
import 'package:people_manager/routes/list.dart';
import 'package:people_manager/widgets/people_list_provider.dart';
import 'package:provider/provider.dart';

// Background color
const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final peopleList = PeopleListProvider();
        for (int i = 0; i < 25; i++) {
          peopleList.add(newRandomPerson());
        }

        return peopleList;
      },
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: darkBlue,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const HomePage(),
          "/list": (context) => const PeopleListingPage(),
          "/create": (context) => CreatePersonPage(
                person: ModalRoute.of(context)!.settings.arguments as Person?,
              ),
        },
      ),
    );
  }
}
