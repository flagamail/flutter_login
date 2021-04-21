import 'login_request.dart';
import 'user.dart';

abstract class RegisterLoginCallBack {
  void onRegisterLoginSuccess(User user);

  void onRegisterLoginError(String error);
}

class RegisterLoginResponse {
  RegisterLoginCallBack _callBack;
  RegisterLoginRequest loginRequest = new RegisterLoginRequest();

  RegisterLoginResponse(this._callBack);

  doLogin(String email, String password) {
    loginRequest
        .getLogin(email, password)
        .then((user) => _callBack.onRegisterLoginSuccess(user))
        .catchError(
            (onError) => _callBack.onRegisterLoginError(onError.toString()));
  }

  doRegister(User user) {
    loginRequest
        .saveUser(user)
        .then((user) => _callBack.onRegisterLoginSuccess(user))
        .catchError(
            (onError) => _callBack.onRegisterLoginError(onError.toString()));
  }
}
