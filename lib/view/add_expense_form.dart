import 'package:flutter/material.dart';
import 'package:google_sheets/controller/form_controller.dart';
import 'package:google_sheets/controller/form_controller_impl.dart';
import 'package:google_sheets/utils/app_mixins.dart';
import 'package:google_sheets/utils/extensions.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> with AppMixins {
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  late FormController _controller;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = FormControllerImpl();
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Expenses",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: Color(0xff121212),
      ),
      body:
          isLoading
              ? Center(
                child: CircularProgressIndicator(color: Color(0xff121212)),
              )
              : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(12),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 12,
                          children: [
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your name";
                                }
                                return null;
                              },
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: "Enter your name",
                                hintStyle: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                enabled: true,
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),

                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your amount";
                                }
                                return null;
                              },
                              controller: _amountController,
                              decoration: InputDecoration(
                                hintText: "Enter amount",
                                hintStyle: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),

                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color(0xff121212),
                        ),
                        fixedSize: WidgetStatePropertyAll(
                          Size(context.screenWidth, 50),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          await _controller
                              .submitForm(
                                name: _nameController.text,
                                date: getDateFormate(
                                  DateTime.now(),
                                  "dd-MM-yyyy",
                                ),
                                amount: checkValueInteger(
                                  _amountController.text,
                                ),
                              )
                              .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Successfulle added!!"),
                                  ),
                                );
                                _nameController.clear();
                                _amountController.clear();
                              });
                          isLoading = false;
                          setState(() {});
                        }
                      },
                      child: Text(
                        "Submit",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
