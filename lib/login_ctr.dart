import 'dart:async';

import 'database_helper.dart';
import 'user.dart';

class RegisterLoginCtr {
  DatabaseHelper con = new DatabaseHelper();

//insertion
  Future<User> saveUser(User user) async {
    var dbClient = await con.db;
    int intRowId = await dbClient.insert("User", user.toMap());
    print('asdf user inserted $intRowId');
    return getLogin(user.email, user.password);
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

    print('asdf getLogin $res');
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
