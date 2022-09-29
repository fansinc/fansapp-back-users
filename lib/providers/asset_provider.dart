import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class AssetProvider with ChangeNotifier {
  late String _tokenVal;
  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<String> uploadBase64Image(image) async {
    String? errorMessage;
    String uUID;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.assetsUrl}';
      //print(url);

      final inputBodyVal = image;
      //json.encode({image});

      final assetMapResponse = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'image/jpeg',
            //'application/json',
            'Authorization': 'Bearer $_tokenVal'
          },
          body: inputBodyVal);

      if (assetMapResponse.statusCode < 400) {
        final assetMapData =
            json.decode(assetMapResponse.body) as Map<String, dynamic>;
        uUID = assetMapData['data']['id'];
        notifyListeners();
        return uUID;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(assetMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
