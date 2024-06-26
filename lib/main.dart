import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/password_event.dart';
import 'presentation/screens/main_screen.dart';
import 'bloc/password_bloc.dart';
import 'infrastructure/repositories/password_repository_impl.dart';
import 'infrastructure/storage/local_storage.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localDataSource = await LocalStorage().dataSource;
  final passwordRepository = PasswordRepositoryImpl(localDataSource);

  runApp(MyApp(passwordRepository: passwordRepository));
}

class MyApp extends StatelessWidget {
  final PasswordRepositoryImpl passwordRepository;

  MyApp({required this.passwordRepository});


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Генератор паролей',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'MontserratAlternates',
      ),
      home: BlocProvider(
        create: (context) => PasswordBloc(passwordRepository: passwordRepository)..add(LoadPasswords()),
        child: MainScreen(),
      ),
    );
  }
}
