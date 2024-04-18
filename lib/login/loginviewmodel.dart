import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

class LoginFormData {
  String email = '';
  String password = '';

  bool isValid() {
    return email.isNotEmpty && password.isNotEmpty;
  }
}

class LoginViewModel extends BaseViewModel {
  Dio _dio = Dio();

  LoginFormData _formData = LoginFormData();
  String _errorMessage = '';
  String _successMessage = '';
  bool _hasError = false;
  bool _isSuccess = false;

  LoginFormData get formData => _formData;
  String get errorMessage => _errorMessage;

  bool get hasError => _hasError;
  bool get isSuccess => _isSuccess;

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setErrorState(bool state) {
    _hasError = state;
    notifyListeners();
  }

  void setSuccessState(bool state) {
    _isSuccess = state;
    notifyListeners();
  }

  validateEmail(String email) {
    _formData.email = email;

    setErrorState(false);
    setSuccessState(false);
    notifyListeners();
  }

  validatePassword(String password) {
    _formData.password = password;
    setErrorState(false);
    setSuccessState(false);
    notifyListeners();
  }

  validateLogin() async {
    if (_formData.isValid()) {
      try {
        setBusy(true);
        var response = await _dio
            .post('https://api.all-attend.com/dev-api/auth/admin-login', data: {
          'email': _formData.email,
          'password': _formData.password,
        });
        if (response.statusCode == 200) {
          setBusy(false);
          setSuccessState(true);
          print('Login Successful');
        } else {
          setErrorState(true);
          setErrorMessage('Error: ${response.statusCode}');
        }
      } catch (e) {
        setErrorState(true);
        setErrorMessage('Error: $e');
      } finally {
        setBusy(false);
      }
    } else {
      setErrorState(true);
      setErrorMessage('Please enter valid email and password');
    }
  }

  setContext(BuildContext context) {}
}
