import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class AuthProvider with ChangeNotifier {
  late String _tokenVal;
  late String _expiryTime;

  Future<void> setToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', _tokenVal);
    _prefs.setString('expires_in', _expiryTime);
  }

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //_prefs.setString('token', _tokenVal);
    return _prefs.getString('token');
  }

  Future<void> authenticate(String email, String password) async {
    String? errorMessage;

    try {
      const url = '${AppConfig.baseUrl}${AppConfig.authToken}';

      final inputBodyVal = json.encode({
        "grant_type": AppConfig.grantType,
        "client_id": AppConfig.clientId,
        "client_secret": AppConfig.clientSecret,
        "username": email,
        "password": password,
      });

      final authMapResponse = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json'
          },
          body: inputBodyVal);

      if (authMapResponse.statusCode < 400) {
        _tokenVal = json.decode(authMapResponse.body)['access_token'];
        _expiryTime =
            json.decode(authMapResponse.body)['expires_in'].toString();
        /* var expiryDateTime =
            Duration(milliseconds: DateTime.now().millisecondsSinceEpoch) +
                Duration(seconds: _expiryTime); */
        //print(expiryDateTime);
        //print(_tokenVal);
        setToken();
        notifyListeners();
      } else {
        //print(json.decode(authMapResponse.body));
        errorMessage = json.decode(authMapResponse.body)['message'];
        //print('Error Registering the User');
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  Future<void> logout() async {
    _tokenVal = '';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', _tokenVal);
    notifyListeners();
  }

  Future<String?> autoLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _tokenVal = _prefs.getString('token')!;
    _expiryTime = _prefs.getString('expires_in')!;
    notifyListeners();
    return _prefs.getString('token');
  }

  Future<void> forgotPassword(String email) async {
    String? errorMessage;

    try {
      const url = '${AppConfig.baseUrl}${AppConfig.forgotPasswordUrl}';

      final inputBodyVal = json.encode({
        "email": email,
        "url": AppConfig.forgotPasswordBodyUrl,
      });

      final authMapResponse = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json'
          },
          body: inputBodyVal);

      if (authMapResponse.statusCode < 400) {
        /* var expiryDateTime =
            Duration(milliseconds: DateTime.now().millisecondsSinceEpoch) +
                Duration(seconds: _expiryTime); */
        //print(expiryDateTime);
        //print(_tokenVal);

        notifyListeners();
      } else {
        //print(json.decode(authMapResponse.body));
        errorMessage = json.decode(authMapResponse.body)['message'];
        //print('Error Registering the User');
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
