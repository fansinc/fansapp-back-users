import 'dart:convert';

import '/models/my_week_model.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class MyWeekProvider with ChangeNotifier {
  late String _tokenVal;

  List<MyWeekModel> myWeekModelList = [];

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<MyWeekModel>> fetchSetMyWeek() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.myWeekUrl}';

      /*  final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      }); */

      final myWeekMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (myWeekMapResponse.statusCode < 400) {
        final myWeekMapData =
            json.decode(myWeekMapResponse.body) as Map<String, dynamic>;
        myWeekMapData.forEach((key, value) {
          if (key == 'data') {
            myWeekModelList = [];
            //Map<String, dynamic> newsMap;
            for (int i = 0; i < value.length; i++) {
              final assetList = value[i]['Assets']['data'];
              List<String> imageList = [];
              for (int j = 0; j < assetList.length; j++) {
                imageList.add(value[i]['Assets']['data'][j]['links']['full']);
              }
              myWeekModelList.add(
                MyWeekModel(
                  id: value[i]['id'],
                  playerId: value[i]['player_id'],
                  playerName: value[i]['player_name'],
                  statusId: value[i]['status_id'],
                  statusName: value[i]['status_name'],
                  image: imageList,
                  // value[i]['Assets']['data'][0]['links']['full'],
                  //['data'][0]['links']['full'],
                ),
              );
            }
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return myWeekModelList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(myWeekMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  Future<void> createMyWeek(playerId, statusId, uUID) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.myWeekUrl}';

      final inputBodyVal = json.encode({
        "player_id": playerId,
        "status_id": statusId,
        "uuid": uUID,
      });
      // print(url);
      final myWeekMapResponse = await post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        body: inputBodyVal,
      );

      if (myWeekMapResponse.statusCode < 400) {
        notifyListeners();
        // return newsModelList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(myWeekMapResponse.body)['message'];
        //['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
