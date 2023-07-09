import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

const people = [
  Person(name: 'Praise', age: 9, emoji: '👶'),
  Person(name: 'Chuks', age: 20, emoji: '🧑‍🦰'),
  Person(name: 'Favy', age: 24, emoji: '👩‍🦰'),
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('People')),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(person: person),
                )),
            title: Text(person.name),
            subtitle: Text('${person.age} years old'),
            leading: Hero(
              tag: person.emoji,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          );
        },
      ),
    );
  }
}

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({required this.name, required this.age, required this.emoji});
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.person});
  final Person person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (flightContext, animation, flightDirection,
              fromHeroContext, toHeroContext) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return ScaleTransition(
                  scale: animation.drive(Tween<double>(
                    begin: 0,
                    end: 1.5,
                  ).chain(CurveTween(curve: Curves.bounceOut))),
                  child: Material(
                      color: Colors.transparent, child: toHeroContext.widget),
                );

              case HeroFlightDirection.pop:
                return Material(
                    color: Colors.transparent, child: fromHeroContext.widget);
            }
          },
          tag: person.emoji,
          child: Text(
            person.emoji,
            style: const TextStyle(fontSize: 50),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              person.name,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${person.age} years old',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
