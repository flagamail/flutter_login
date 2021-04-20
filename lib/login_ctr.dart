import 'dart:async';

import 'database_helper.dart';
import 'user.dart';

class RegisterLoginCtr {
  DatabaseHelper con = new DatabaseHelper();

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<User> getLogin(String email, String password) async {
    var dbClient = await con.db;
    var res = await dbClient
        .rawQuery("SELECT * FROM user WHERE email = '$email' and password = '"
            "$password'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }
    return null;
  }

  Future<List<User>> getAllUser() async {
    var dbClient = await con.db;
    var res = await dbClient.query("user");

    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;
    return list;
  }
}
