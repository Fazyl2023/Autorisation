import 'dart:math';

import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Анкета"),
      ),
      body: Container(
        color: Color.fromARGB(255, 0, 0, 0),
        constraints: BoxConstraints.expand(),
        child: Column(children: <Widget>[
          Divider(height: 10.0, color: Theme.of(context).primaryColor),
          //DropdownButtonExample(),

          DropDownField(
            controller: ag,
            hintText: 'сумма кредита',
            labelText: 'Сумма займа*',
            icon: Icon(Icons.account_balance_wallet),
            enabled: true,
            items: age,
            textStyle: TextStyle(
                color: const Color.fromARGB(
                    255, 255, 255, 255)), // Укажите нужный цвет здесь

            itemsVisibleInDropdown: 5,
            setter: (dynamic newValue) {
              select_age = newValue;
            },

            //onValueChanged: (value) {}
          ),
          Divider(height: 30.0, color: Theme.of(context).primaryColor),
          DropDownField(
              controller: ed,
              hintText: 'Введите полную стоимость кредита',
              labelText: 'Полная стоимость кредита*',
              icon: Icon(Icons.account_balance),
              enabled: true,
              items: education,
              itemsVisibleInDropdown: 5,
              textStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              setter: (dynamic newValue) {
                select_education = newValue;
              }),
          Divider(height: 30.0, color: Theme.of(context).primaryColor),
          DropDownField(
              controller: se,
              hintText: 'Выберите срок кредита',
              labelText: 'Срок кредита *',
              icon: Icon(Icons.access_time_filled_rounded),
              enabled: true,
              items: sex,
              itemsVisibleInDropdown: 5,
              textStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              setter: (dynamic newValue) {
                select_education = newValue;
              }),
          Divider(height: 30.0, color: Theme.of(context).primaryColor),
          DropDownField(
              controller: ca,
              hintText: 'Укажите статус кредита',
              labelText: 'Статус кредита*',
              icon: Icon(Icons.insert_chart_outlined_sharp),
              enabled: true,
              items: doxod,
              textStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              itemsVisibleInDropdown: 2,
              setter: (dynamic newValue) {
                select_cash = newValue;
              }),

          Divider(height: 30.0, color: Theme.of(context).primaryColor),
          DropDownField(
              controller: sp,
              hintText: 'Укажите тип кредита',
              labelText: 'Тип кредита *',
              icon: Icon(Icons.abc),
              enabled: true,
              items: sem_pol,
              textStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              itemsVisibleInDropdown: 2,
              setter: (dynamic newValue) {
                select_sem_pol = newValue;
              }),

          Divider(height: 30.0, color: Theme.of(context).primaryColor),
          DropDownField(
              controller: otn,
              hintText: 'Укажите тип отношения к кредиту',
              labelText: 'Тип отношения *',
              icon: Icon(Icons.account_circle_rounded),
              enabled: true,
              items: tip_otn,
              textStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              itemsVisibleInDropdown: 3,
              setter: (dynamic newValue) {
                select_otn = newValue;
              }),
          Divider(height: 30.0, color: Theme.of(context).primaryColor),

          DropDownField(
              controller: pros,
              hintText: 'Укажите, есть ли у вас просрочки',
              labelText: 'Наличие просрочек*',
              icon: Icon(Icons.access_alarm),
              enabled: true,
              items: prosrocka,
              textStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              itemsVisibleInDropdown: 2,
              setter: (dynamic newValue) {
                select_pros = newValue;
              }),

          Divider(height: 30.0, color: Theme.of(context).primaryColor),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: () async {
                await Future.delayed(Duration(seconds: 4));

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Result()),
                );
              },
              child: Text('Оценить'))
        ]),
      ),
    );
  }
}

String select_age = '';
String select_education = '';
String select_sex = '';
String select_cash = '';
String select_sem_pol = '';

String select_otn = '';
String select_pros = '';
String select_lim = '';

final ag = TextEditingController();
final ed = TextEditingController();
final se = TextEditingController();
final ca = TextEditingController();
final sp = TextEditingController();
final otn = TextEditingController();
final pros = TextEditingController();
final lim = TextEditingController();

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

const List<String> age = <String>[
  '100 000',
  '500 000',
  '1 000 000',
  '5 000 000',
  '10 000 000'
];
const List<String> sex = <String>[
  '1 год',
  '2 года',
  '3 года',
  '5 лет',
  '10 лет',
  '20 лет'
];

const List<String> education = <String>[
  '100 000',
  '500 000',
  '1 000 000',
  '5 000 000',
  '10 000 000'
];

const List<String> doxod = <String>['активен', 'закрыт', 'просрочен'];

const List<String> sem_pol = <String>[
  'автокредит',
  'ипотека',
  'кредитная карта',
];

const List<String> tip_otn = <String>[
  'заемщик',
  'поручитель',
  'юридическое лицо'
];

const List<String> prosrocka = <String>[
  'Есть',
  'Нет',
];
