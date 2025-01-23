import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_mobile/main.dart';
import 'package:http/http.dart' as http;
import 'server.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _message;

  // Функция для отправки данных на сервер
  Future<void> authUser(String login, String password) async {
    final url = Uri.parse('http://127.0.0.1:8000/auth/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'login': login, 'password': password}),
      );
      final resultat = jsonDecode(response.body);
      if (response.statusCode == 200 && resultat['status'] == 'success') {
        setState(() {
          _message = "Успешеный вход";
        });
      } else {
        setState(() {
          _message = resultat['detail'] ?? "Ошибка авторизации";
        });
      }
    } catch (e) {
      setState(() {
        _message = "Ошибка подключения: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вход')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Divider(height: 170.0, color: Theme.of(context).primaryColor),
            //DropdownButtonExample(),

            TextField(
              controller: _loginController,
              decoration: InputDecoration(labelText: 'Логин'),
            ),

            Divider(height: 40.0, color: Theme.of(context).primaryColor),

            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final login = _loginController.text;
                final password = _passwordController.text;

                if (login.isEmpty || password.isEmpty) {
                  setState(() {
                    _message = "Заполните все поля!";
                  });
                } else {
                  await authUser(login, password);
                }
              },
              child: Text('Войти'),
            ),

            if (_message != null) ...[
              SizedBox(height: 20),
              Text(
                _message!,
                style:
                    TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
