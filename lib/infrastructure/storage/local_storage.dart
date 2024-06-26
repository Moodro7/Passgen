import 'package:shared_preferences/shared_preferences.dart';
import '../data_sources/local_data_source.dart';

class LocalStorage {
  Future<LocalDataSource> get dataSource async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return LocalDataSource(sharedPreferences);
  }
}
