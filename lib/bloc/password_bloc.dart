import 'package:flutter_bloc/flutter_bloc.dart';
import 'password_event.dart';
import 'password_state.dart';
import '../domain/repositories/password_repository.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordRepository passwordRepository;

  PasswordBloc({required this.passwordRepository}) : super(PasswordInitial()) {
    on<AddPassword>(_onAddPassword);
    on<DeletePassword>(_onDeletePassword);
    on<LoadPasswords>(_onLoadPasswords);
  }

  void _onAddPassword(AddPassword event, Emitter<PasswordState> emit) async {
    final passwords = await passwordRepository.addPassword(
      event.service,
      event.login,
      event.password,
    );
    emit(PasswordLoadSuccess(passwords));
  }

  void _onDeletePassword(DeletePassword event, Emitter<PasswordState> emit) async {
    final passwords = await passwordRepository.deletePassword(event.index);
    emit(PasswordLoadSuccess(passwords));
  }

  void _onLoadPasswords(LoadPasswords event, Emitter<PasswordState> emit) async {
    final passwords = await passwordRepository.loadPasswords();
    emit(PasswordLoadSuccess(passwords));
  }
}
