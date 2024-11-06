import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/button_model.dart';

class JsonService {
  static Future<List<ButtonModel>> loadButtons() async {
    final String response = await rootBundle.loadString('assets/data/buttons.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => ButtonModel.fromJson(json)).toList();
  }

  static Future<void> saveButtons(List<ButtonModel> buttons) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(buttons.map((button) => button.toJson()).toList());
    await prefs.setString('buttons', jsonString);
  }

  static Future<List<ButtonModel>> getSavedButtons() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('buttons');
    if (jsonString != null) {
      final List<dynamic> data = json.decode(jsonString);
      return data.map((json) => ButtonModel.fromJson(json)).toList();
    } else {
      return await loadButtons();
    }
  }
}
