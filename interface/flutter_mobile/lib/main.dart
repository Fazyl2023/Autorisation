import 'dart:math';

import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'starflut.dart';
//import 'package:starflut/starflut.dart';
import 'server.dart';
import 'vkhod.dart';

void main() {
  runApp(const MyApp());

  //runApp(const FirstRoute());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
            background: Color.fromARGB(255, 255, 255, 255)),
      ),
      home: const FirstPage(),
    );
  }
}

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Результат"),
      ),
      body: Container(
        color: Colors.black,
        child: Column(children: <Widget>[
          Divider(height: 90.0, color: Theme.of(context).primaryColor),
          Text(
            'Вероятность: 0,81',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Divider(height: 90.0, color: Theme.of(context).primaryColor),
          Text(
            'Ваша заявка на кредит будет одобрена',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}

int count = 0;
String dropdownValue = 'Dog';

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = sex.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      //DropdownButton<String>(

      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 2,
      style: const TextStyle(color: Color.fromARGB(255, 255, 254, 255)),

      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: sex.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: <Widget>[
                Icon(Icons.attribution_rounded),
                Text(value),
              ],
            ));
      }).toList(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Кредитный скоринг"), // Заголовок основного раздела
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Divider(height: 170.0, color: Theme.of(context).primaryColor),
            ButtonFirstPage('Новая оценка', 'Перейти', const SecondRoute()),
            Divider(height: 90.0, color: Theme.of(context).canvasColor),
            ButtonFirstPage('Регистрация и вход', 'Перейти', AuthScreen())

            // ButtonFirstPage(
            //      'Справочная информация', 'Перейти', const FirstPage()),
            //ButtonFirstPage('прочее', const MyApp1()),
          ],
        ),
      ),
    );
  }
}

class ButtonFirstPage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ButtonFirstPage(this.text1, this.text, this.route, {super.key});
  final String text;
  final String text1;
  // ignore: prefer_typing_uninitialized_variables
  final route;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              width: 300.0,
              height: 200.0,
              color: Color.fromARGB(253, 249, 249, 249),
              child: Column(
                children: <Widget>[
                  Text(
                    text1,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // icon: Icons.app_registration_outlined,
                  Divider(height: 48.0, color: Theme.of(context).primaryColor),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      fixedSize: const Size(300, 80),
                      foregroundColor: Colors.black,
                      backgroundColor: Color.fromARGB(255, 168, 118, 255),
                      elevation: 15.0,
                      padding: EdgeInsets.all(20),
                      onPrimary: Colors.black87,
                      side: BorderSide(color: Colors.black87, width: 2),
                    ),
                    child: Text(text),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => route),
                      );
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

//Http

Future<Album> fetchAlbum() async {
  String urlString = "https://www.banki.ru/ng/api/v1.0/public/user/client/info";
  Uri uri = Uri.parse(urlString);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final ip;
  final o;
  final win;

  Album({required this.ip, required this.o, required this.win});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      ip: json['ip'],
      o: json['Оценка вина'],
      win: json['вероятность'],
    );
  }
}

class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp1> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Пример',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
            background: Color.fromARGB(255, 255, 255, 255)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Пример'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.o.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
