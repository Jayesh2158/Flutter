import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureData {
  static final _storage = FlutterSecureStorage();
  String name;
  String email;
  String password;
  String mobile;
  String photo;

  SecureData({this.name, this.email, this.password, this.mobile, this.photo});

  saveData() async {
    await _storage.write(
        key: email,
        value:
            '{"name":"$name","password":"$password","mobile":$mobile,"photo":"$photo"}');
  }

  checkEmail(String id) async {
    var result = await _storage.read(key: id);
    return result;
  }

  clearData() async {
    await _storage.deleteAll();
  }
}
