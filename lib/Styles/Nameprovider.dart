import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NameStorageNotifier extends StateNotifier<String?> {
  NameStorageNotifier() : super(null) {
    _loadSavedName(); 
  }

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(),
    webOptions: WebOptions(
      dbName: 'flutter_secure_storage',
      
    ),
  );

  Future<void> _loadSavedName() async {
    String? savedName = await _storage.read(key: 'saved_name');
    state = savedName;
  }

  Future<void> saveName(String name) async {
    await _storage.write(key: 'saved_name', value: name);
    state = name; 
  }
}

final nameStorageProvider =
    StateNotifierProvider<NameStorageNotifier, String?>((ref) {
  return NameStorageNotifier();
});
