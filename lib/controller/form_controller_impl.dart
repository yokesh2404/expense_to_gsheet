import 'dart:convert';

import 'package:google_sheets/controller/form_controller.dart';
import 'package:google_sheets/model/all_expenses.dart';
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

  @override
  Future<AllExpenses> getAllExpenses() async {
    AllExpenses response = AllExpenses();
    try {
      var result = await http.get(Uri.parse(ApiConfigs.scriptUrl));
      if (result.statusCode == 200) {
        response = AllExpenses.fromJson(jsonDecode(result.body));
      } else {
        response = AllExpenses(success: false, data: []);
      }
    } catch (e) {
      response = AllExpenses(success: false, data: []);
    }
    return response;
  }

  @override
  Stream<AllExpenses> streamAllExpenses() async* {
    while (true) {
      final data = await getAllExpenses();
      yield data;
      await Future.delayed(Duration(seconds: 5)); // Poll every 5 seconds
    }
  }
}
