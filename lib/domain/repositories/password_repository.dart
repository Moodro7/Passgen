abstract class PasswordRepository {
  Future<List<Map<String, String>>> loadPasswords();
  Future<List<Map<String, String>>> addPassword(String service, String login, String password);
  Future<List<Map<String, String>>> deletePassword(int index);
}
