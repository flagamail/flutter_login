const strPassword = "password";
const strEmail = 'email';
const strFirstName = 'first_name';
const strLastName = 'last_name';
const strMobile = 'mobile';

class ModelUser {
  String _email;
  String _password;
  String _firstName, _lastName, _mobile;

  ModelUser(this._email, this._password, this._firstName, this._lastName,
      this._mobile);

  ModelUser.fromMap(dynamic obj) {
    this._email = obj[strEmail];
    this._password = obj[strPassword];
    this._firstName = obj[strFirstName];
    this._lastName = obj[strLastName];
    this._mobile = obj[strMobile];
  }

  String get username => _firstName + " " + _lastName;

  String get mobile => _mobile;

  String get email => _email;

  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[strFirstName] = _firstName;
    map[strLastName] = _lastName;
    map[strMobile] = _mobile;
    map[strEmail] = _email;
    map[strPassword] = _password;
    return map;
  }
}
