import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/password_bloc.dart';
import '../../bloc/password_event.dart';
import '../../bloc/password_state.dart';
import 'package:flutter/services.dart';

class PasswordListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        if (state is PasswordLoadSuccess) if (state.passwords.isEmpty) {
          return Center(child: Text('Здесь будут храниться ваши пароли:)'));
        } else {
          return ListView.builder(
            itemCount: state.passwords.length,
            itemBuilder: (context, index) {
              final passwordData = state.passwords[index];
              return PasswordCard(
                index: index,
                passwordData: passwordData,
              );
            },
          );
        }
        else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class PasswordCard extends StatefulWidget {
  final int index;
  final Map<String, String> passwordData;

  PasswordCard({required this.index, required this.passwordData});

  @override
  _PasswordCardState createState() => _PasswordCardState();
}

class _PasswordCardState extends State<PasswordCard> {
  bool _showPassword = false;

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(widget.passwordData['service']!,
            style: TextStyle(fontSize: 20)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText('Логин: ${widget.passwordData['login']!}'),
            SelectableText(
                'Пароль: ${_showPassword ? widget.passwordData['password'] : '********'}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: _showPassword ? Colors.deepPurple : Colors.grey,
                  size: 18),
              onPressed: _toggleShowPassword,
            ),
            IconButton(
              icon: Icon(Icons.copy, color: Colors.deepPurple, size: 18),
              onPressed: () {
                Clipboard.setData(
                    new ClipboardData(text: widget.passwordData['password']!));
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Пароль успешно скопирован!')));
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.pinkAccent, size: 18),
              onPressed: () {
                context.read<PasswordBloc>().add(DeletePassword(widget.index));
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Пароль успешно удалён!')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
