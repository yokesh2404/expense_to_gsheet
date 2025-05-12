import 'package:google_sheets/model/all_expenses.dart';

abstract class FormController {
  Future<void> submitForm({
    required String name,
    required String date,
    required int amount,
  });

  Future<AllExpenses> getAllExpenses();
  Stream<AllExpenses> streamAllExpenses();
}
