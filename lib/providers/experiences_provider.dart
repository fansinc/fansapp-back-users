import 'dart:convert';

import '/models/experiences_model.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class ExperiencesProvider with ChangeNotifier {
  late String _tokenVal;

  List<ExperiencesModel> experiencesModelList = [];

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<ExperiencesModel>> fetchSetExperiences() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.experienceUrl}';

      /*  final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      }); */

      final experiencesMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (experiencesMapResponse.statusCode < 400) {
        final experiencesData =
            json.decode(experiencesMapResponse.body) as Map<String, dynamic>;
        experiencesData.forEach((key, value) {
          if (key == 'data') {
            experiencesModelList = [];
            //Map<String, dynamic> newsMap;
            for (int i = 0; i < value.length; i++) {
              experiencesModelList.add(
                ExperiencesModel(
                  id: value[i]['id'],
                  description: value[i]['description'],
                  playerId: value[i]['player_id'],
                  playerName: value[i]['player_name'],
                  statusId: value[i]['status_id'],
                  statusName: value[i]['status_name'],
                  price: value[i]['price'],
                  createdAt: value[i]['created_at'],
                  title: value[i]['title'],
                  image: value[i]['Assets']['data'][0]['links']['full'],
                  //['data'][0]['links']['full'],
                ),
              );
            }
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return experiencesModelList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(experiencesMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  Future<void> createExperience(
      playerId, title, description, price, statusId, uUID) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.experienceUrl}';

      final inputBodyVal = json.encode({
        "player_id": playerId,
        "title": title,
        "description": description,
        "price": price,
        "status_id": statusId,
        "uuid": uUID,
      });
      // print(url);
      final expMapResponse = await post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        body: inputBodyVal,
      );

      if (expMapResponse.statusCode < 400) {
        notifyListeners();
        // return newsModelList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(expMapResponse.body)['message'];
        //['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
