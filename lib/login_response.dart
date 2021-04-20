import 'login_request.dart';
import 'user.dart';

abstract class LoginCallBack {
  void onLoginSuccess(User user);

  void onLoginError(String error);
}

class LoginResponse {
  LoginCallBack _callBack;
  RegisterLoginRequest loginRequest = new RegisterLoginRequest();

  LoginResponse(this._callBack);

  doLogin(String email, String password) {
    loginRequest
        .getLogin(email, password)
        .then((user) => _callBack.onLoginSuccess(user))
        .catchError((onError) => _callBack.onLoginError(onError.toString()));
  }
}
