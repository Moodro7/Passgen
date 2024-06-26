import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/password_bloc.dart';
import '../widgets/char_button.dart';
import '../../bloc/password_event.dart';
import 'dart:math';
import 'main_screen.dart';

Widget passwordStrength(double entropy) {
  if (entropy == 0){
    return SizedBox.shrink();
  }
  else if (entropy <= 21) {
    return Text('Плохой пароль', style: TextStyle(color: Colors.red));
  } else if (entropy <= 36) {
    return Text('Ненадежный пароль', style: TextStyle(color: Colors.orange));
  } else if (entropy <= 50) {
    return Text('Хороший пароль', style: TextStyle(color: Colors.yellow));
  } else if (entropy <= 100) {
    return Text('Отличный пароль', style: TextStyle(color: Colors.lightGreen));
  } else {
    return Text('Безопасный пароль', style: TextStyle(color: Colors.green));
  }
}

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() => _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  String _password = '';
  int _maxLength = 4;
  Set<String> _selectedCharSets = {};
  double _entropy = 0;
  Color _passwordStrengthColor = Colors.black;
  TextEditingController _serviceController = TextEditingController();
  TextEditingController _loginController = TextEditingController();

  void _passwordEntropy() {
    if (_selectedCharSets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пароль успешно сгенерирован!')),
      );
    }
    double totalEntropy = 0.0;
    for (String charSet in _selectedCharSets) {
      double entropy = 0.0;
      if (charSet == 'uppercaseEnglish') {
        entropy = 26.0;
      } else if (charSet == 'lowercaseEnglish') {
        entropy = 26.0;
      } else if (charSet == 'lowercaseRussian') {
        entropy = 33.0;
      } else if (charSet == 'uppercaseRussian') {
        entropy = 33.0;
      } else if (charSet == 'numbers') {
        entropy = 10.0;
      } else if (charSet == 'specialCharacters') {
        entropy = 27.0;
      }
      totalEntropy += entropy;
    }
    double finalEntropy = log(pow(totalEntropy, _maxLength)) / log(2);
    setState(() {
      _entropy = finalEntropy;
      _passwordStrengthColor = _entropy < 36 ? Colors.red : Colors.green;
    });
  }

  void _generatePassword() {
    setState(() {
      String characters = '';
      if (_selectedCharSets.contains('uppercaseEnglish'))
        characters += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      if (_selectedCharSets.contains('lowercaseEnglish'))
        characters += 'abcdefghijklmnopqrstuvwxyz';
      if (_selectedCharSets.contains('uppercaseRussian'))
        characters += 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
      if (_selectedCharSets.contains('lowercaseRussian'))
        characters += 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя';
      if (_selectedCharSets.contains('numbers')) characters += '0123456789';
      if (_selectedCharSets.contains('specialCharacters'))
        characters += r'!@#$%^&*()_-+=[]{}|;:,.<>?';

      String password = '';
      final random = Random();
      for (int i = 0; i < _maxLength; i++) {
        password += characters[random.nextInt(characters.length)];
      }
      _password = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _serviceController,
          decoration: InputDecoration(labelText: 'Сервис'),
          keyboardType: TextInputType.text,
        ),
        TextField(
          controller: _loginController,
          decoration: InputDecoration(labelText: 'Логин'),
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.0,
          children: [
            CharButton(label: 'A-Z', charSet: 'uppercaseEnglish', selectedCharSets: _selectedCharSets, onSelectionChanged: () => setState(() {})),
            CharButton(label: 'a-z', charSet: 'lowercaseEnglish', selectedCharSets: _selectedCharSets, onSelectionChanged: () => setState(() {})),
            CharButton(label: 'А-Я', charSet: 'uppercaseRussian', selectedCharSets: _selectedCharSets, onSelectionChanged: () => setState(() {})),
            CharButton(label: 'а-я', charSet: 'lowercaseRussian', selectedCharSets: _selectedCharSets, onSelectionChanged: () => setState(() {})),
            CharButton(label: '0-9', charSet: 'numbers', selectedCharSets: _selectedCharSets, onSelectionChanged: () => setState(() {})),
            CharButton(label: '!@...', charSet: 'specialCharacters', selectedCharSets: _selectedCharSets, onSelectionChanged: () => setState(() {})),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Длина: '),
            Slider(
              value: _maxLength.toDouble(),
              min: 4.0,
              max: 64.0,
              onChanged: (double value) {
                setState(() {
                  _maxLength = value.toInt();
                });
              },
            ),
            Text('$_maxLength'),
          ],
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            if (_selectedCharSets.isEmpty){
              //showErrorAlert(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Пожалуйста, выберите хотя бы один набор символов.')),
              );
            }
            else{
            _generatePassword();
            _passwordEntropy();
            //showSuccessAlert(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Пароль успешно сгенерирован!')),
            );
            context.read<PasswordBloc>().add(AddPassword(_serviceController.text, _loginController.text, _password));
            }
          },
          child: Text('Генерировать'),
        ),
        SizedBox(height: 16.0),
        SelectableText('Ваш пароль: $_password',
            style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 16.0),
        passwordStrength(_entropy),
      ],
    );
  }
}
