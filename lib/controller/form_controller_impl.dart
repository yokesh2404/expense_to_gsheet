import 'dart:convert';

import 'package:google_sheets/controller/form_controller.dart';
import 'package:google_sheets/utils/api_configs.dart';

import 'package:http/http.dart' as http;

class FormControllerImpl extends FormController {
  @override
  Future<void> submitForm({
    required String name,
    required String date,
    required int amount,
  }) async {
    try {
      var req = {"date": date, "name": name, "amount": amount};

      var response = await http.post(
        Uri.parse(ApiConfigs.scriptUrl),
        body: jsonEncode(req),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      print(e);
    }
  }
}
