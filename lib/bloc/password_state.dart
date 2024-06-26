import 'package:equatable/equatable.dart';

abstract class PasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class PasswordInitial extends PasswordState {}

class PasswordLoadSuccess extends PasswordState {
  final List<Map<String, String>> passwords;

  PasswordLoadSuccess(this.passwords);

  @override
  List<Object> get props => [passwords];
}
