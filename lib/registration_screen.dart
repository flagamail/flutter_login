import 'package:flutter/material.dart';

import 'login_request.dart';
import 'user.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _email, _password, _firstName, _lastName, _mobile;

  void _submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
      });
      User user = User(_email, _password, _firstName, _lastName, _mobile);
      await RegisterLoginRequest().saveUser(user);
      _showSnackBar("Registration Success");
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var registrationBtn = RaisedButton(
      onPressed: _submit,
      child: Text("Login"),
      color: Colors.green,
    );
    var registrationForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _firstName = val,
                  decoration: InputDecoration(labelText: "First Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _lastName = val,
                  decoration: InputDecoration(labelText: "Last Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _mobile = val,
                  decoration: InputDecoration(labelText: "Mobile"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _email = val,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: "Password"),
                ),
              )
            ],
          ),
        ),
        registrationBtn
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Page"),
      ),
      key: scaffoldKey,
      body: Container(
        child: Center(
          child: registrationForm,
        ),
      ),
    );
  }
}
