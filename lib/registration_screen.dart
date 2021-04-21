import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'login_response.dart';
import 'user.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    implements RegisterLoginCallBack {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _email, _password, _firstName, _lastName, _mobile;
  final edgeInsets = const EdgeInsets.all(10.0);
  RegisterLoginResponse _responseRegister;

  _RegistrationPageState() {
    _responseRegister = RegisterLoginResponse(this);
  }

  void _submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
      });
      ModelUser user =
          ModelUser(_email, _password, _firstName, _lastName, _mobile);
      await _responseRegister.doRegister(user);
    }
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var registrationBtn = ElevatedButton(
      onPressed: _isLoading ? null : _submit,
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Text("Registration"),
    );
    var registrationForm = ListView(
      shrinkWrap: true,
      children: <Widget>[
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: edgeInsets,
                child: TextFormField(
                  onSaved: (val) => _firstName = val.trim(),
                  decoration: InputDecoration(labelText: "First Name"),
                ),
              ),
              Padding(
                padding: edgeInsets,
                child: TextFormField(
                  onSaved: (val) => _lastName = val.trim(),
                  decoration: InputDecoration(labelText: "Last Name"),
                ),
              ),
              Padding(
                padding: edgeInsets,
                child: TextFormField(
                  onSaved: (val) => _mobile = val.trim(),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: "Mobile"),
                ),
              ),
              Padding(
                padding: edgeInsets,
                child: TextFormField(
                  onSaved: (val) => _email = val.trim(),
                  validator: (val) => EmailValidator.validate(val.trim())
                      ? null
                      : ""
                          "Invalid Email",
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              Padding(
                padding: edgeInsets,
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  validator: (val) => val.length >= 6
                      ? null
                      : "Minimum 6 "
                          "characters",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(labelText: "Password"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Registration Page"),
      ),
      key: scaffoldKey,
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom + 48,
            top: 0,
            left: 0,
            right: 0,
            child: registrationForm,
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: registrationBtn,
          ),
        ],
      ),
    );
  }

  @override
  void onRegisterLoginError(String error) {
    _showSnackBar("Registration Failed, please retry");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onRegisterLoginSuccess(ModelUser user) {
    if (user != null) {
      _showSnackBar("Registration Success, Login");
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      _showSnackBar("Registration Failed, please retry");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
