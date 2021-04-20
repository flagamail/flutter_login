const strPassword = "password";
const strEmail = 'email';
const strFirstName = 'firstName';
const strLastName = 'lastName';
const strMobile = 'mobile';

class User {
  int _id;
  String _email;
  String _password;
  String _firstName, _lastName, _mobile;

  User(this._email, this._password, this._firstName, this._lastName,
      this._mobile);

  User.fromMap(dynamic obj) {
    this._email = obj[strEmail];
    this._password = obj[strPassword];
    this._firstName = obj[strFirstName];
    this._lastName = obj[strLastName];
    this._mobile = obj[strMobile];
  }

  String get username => _email;

  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map[strEmail] = _email;
    map[strPassword] = _password;
    map[strFirstName] = _firstName;
    map[strLastName] = _lastName;
    map[strMobile] = _mobile;
    return map;
  }
}
