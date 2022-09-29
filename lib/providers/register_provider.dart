import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';

class RegisterProvider with ChangeNotifier {
  Future<void> registerUser(String firstName, String lastName, String email,
      String password, String confirmPassword, String mobile) async {
    String? errorMessage;

    try {
      const url = '${AppConfig.baseUrl}${AppConfig.registerUserUrl}';

      final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      });

      final registerMapResponse = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json'
          },
          body: inputBodyVal);

      if (registerMapResponse.statusCode < 400) {
        notifyListeners();
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(registerMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
