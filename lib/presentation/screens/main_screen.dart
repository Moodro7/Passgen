import 'package:flutter/material.dart';
import 'password_generator_screen.dart';
import 'password_list_screen.dart';
import 'package:status_alert/status_alert.dart';

void showSuccessAlert(BuildContext context) {
  StatusAlert.show(
    context,
    duration: Duration(seconds: 2),
    title: 'Успех',
    subtitle: 'Пароль успешно сгенерирован!',
    configuration: IconConfiguration(icon: Icons.check),
  );
}

void showErrorAlert(BuildContext context) {
  StatusAlert.show(
    context,
    duration: Duration(seconds: 2),
    title: 'Error',
    subtitle: 'Something went wrong!',
    configuration: IconConfiguration(icon: Icons.error),
  );
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      PasswordGeneratorScreen(),
      PasswordListScreen(),
    ];
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Генератор паролей'),
      ),
      body: Container(
        color: Colors.purple[100],
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500, minHeight: 300),
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.password),
            label: 'Генератор',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Пароли',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
