import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _message;

  // Функция для отправки данных на сервер
  Future<void> registerUser(String login, String password) async {
    final url =
        Uri.parse('http://127.0.0.1:8000/register/'); // Замените на ваш сервер
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'login': login, 'password': password}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _message = "Регистрация успешна!";
        });
      } else {
        final error = jsonDecode(response.body)['detail'];
        setState(() {
          _message = "Ошибка: $error";
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
      appBar: AppBar(title: Text('Регистрация')),
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
                  await registerUser(login, password);
                }
              },
              child: Text('Зарегистрироваться'),
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
