import 'dart:convert';

import '/models/profile_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/config/app_config.dart';

class ProfileProvider with ChangeNotifier {
  late String _tokenVal;

  late ProfileModel profileModel;

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<ProfileModel> fetchSetUserProfile() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.profileUrl}';

      /*  final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      }); */

      final profileMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (profileMapResponse.statusCode < 400) {
        final profileData =
            json.decode(profileMapResponse.body) as Map<String, dynamic>;
        profileData.forEach((key, value) {
          if (key == 'data') {
            profileModel = ProfileModel(
              id: value['user_id'],
              fanName: value['name'],
              email: value['email'],
              mobile: value['mobile'],
            );
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return profileModel;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(profileMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  Future<void> updateUserProfile(
      String name, String email, String mobile) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.profileUrl}';

      final inputBodyVal = json.encode({
        "name": name,
        "email": email,
        "mobile": mobile,
      });

      final profileMapResponse = await put(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_tokenVal'
          },
          body: inputBodyVal);

      if (profileMapResponse.statusCode < 400) {
        notifyListeners();
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(profileMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
