import '../../domain/repositories/password_repository.dart';
import '../data_sources/local_data_source.dart';

class PasswordRepositoryImpl implements PasswordRepository {
  final LocalDataSource localDataSource;

  PasswordRepositoryImpl(this.localDataSource);

  @override
  Future<List<Map<String, String>>> loadPasswords() async {
    return await localDataSource.loadPasswords();
  }

  @override
  Future<List<Map<String, String>>> addPassword(String service, String login, String password) async {
    final passwords = await loadPasswords();
    passwords.add({'service': service, 'login': login, 'password': password});
    await localDataSource.savePasswords(passwords);
    return passwords;
  }

  @override
  Future<List<Map<String, String>>> deletePassword(int index) async {
    final passwords = await loadPasswords();
    passwords.removeAt(index);
    await localDataSource.savePasswords(passwords);
    return passwords;
  }
}
