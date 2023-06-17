import "package:flutter_secure_storage/flutter_secure_storage.dart";

class LocalSecureStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  //Write some code in the local storage encrypted
  writeIntoSecureStorage(String value, String key) async {
    await secureStorage.write(
      key: key,
      value: value,
    );
  }

  // Read the data from local storage
  readSecureStorage(String key) async {
    await secureStorage.read(key: key);
  }
}
