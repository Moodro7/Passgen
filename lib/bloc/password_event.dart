import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddPassword extends PasswordEvent {
  final String service;
  final String login;
  final String password;

  AddPassword(this.service, this.login, this.password);

  @override
  List<Object> get props => [service, login, password];
}

class DeletePassword extends PasswordEvent {
  final int index;

  DeletePassword(this.index);

  @override
  List<Object> get props => [index];
}

class LoadPasswords extends PasswordEvent {}
