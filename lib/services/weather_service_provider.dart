import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_response_model.dart';
import 'package:weather_app/secrets/api.dart';

class WeatherServiceProvider extends ChangeNotifier {
  WeatherModel? _weather;
  WeatherModel? get weather => _weather;

  bool _isloading = false;
  bool get isloading => _isloading;

  String _error = '';
  String get error => _error;

  Future<void> fetchWeatherDataByCity(String city) async {
    _isloading = true;
    _error = '';
    https:
    try {
      final String apiUrl =
          '${APIEndPoints().cityUrl}${city}&appid=${APIEndPoints().apikey}${APIEndPoints().unit}';
      print(apiUrl);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        _weather = WeatherModel.fromJson(data);

        notifyListeners();
      } else {
        _error = 'faild to load data';
      }
    } catch (e) {
      _error = 'failed to load data $e';
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}
