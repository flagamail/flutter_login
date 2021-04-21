import 'dart:async';

import 'login_ctr.dart';
import 'user.dart';

class RegisterLoginRequest {
  RegisterLoginCtr con = new RegisterLoginCtr();

  Future<User> getLogin(String email, String password) {
    var result = con.getLogin(email, password);
    return result;
  }

  Future<User> saveUser(User user) async {
    return await con.saveUser(user);
  }
}
