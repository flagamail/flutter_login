import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:inerview_task/home.dart';
import 'package:inerview_task/registration_screen.dart';

import 'login_response.dart';
import 'user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    implements RegisterLoginCallBack {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _email, _password;
  RegisterLoginResponse _responseLogin;

  _LoginPageState() {
    _responseLogin = RegisterLoginResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _responseLogin.doLogin(_email, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var loginBtn = ElevatedButton(
      onPressed: _isLoading ? null : _submit,
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Text("Login"),
    );
    var loginForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _email = val,
                  validator: (val) => EmailValidator.validate(val.trim())
                      ? null
                      : ""
                          "Invalid Email",
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
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
              )
            ],
          ),
        ),
        loginBtn,
        ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => RegistrationPage()));
          },
          child: Text("Register"),
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      key: scaffoldKey,
      body: Container(
        child: Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onRegisterLoginError(String error) {
    _showSnackBar("Login Failed, please retry or Register");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onRegisterLoginSuccess(ModelUser user) async {
    if (user != null) {
      _showSnackBar("Login Success");
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Dashboard(user)));
    } else {
      _showSnackBar("Login Failed, please retry");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
