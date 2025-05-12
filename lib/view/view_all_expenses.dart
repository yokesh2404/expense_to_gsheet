import 'package:flutter/material.dart';
import 'package:google_sheets/controller/form_controller.dart';
import 'package:google_sheets/controller/form_controller_impl.dart';
import 'package:google_sheets/utils/app_decorations.dart';
import 'package:google_sheets/utils/app_mixins.dart';

class ViewAllExpenses extends StatefulWidget {
  const ViewAllExpenses({super.key});

  @override
  State<ViewAllExpenses> createState() => _ViewAllExpensesState();
}

class _ViewAllExpensesState extends State<ViewAllExpenses> with AppMixins {
  late FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormControllerImpl();
    _controller.getAllExpenses();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          "All Expenses",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: Color(0xff121212),
      ),
      body: StreamBuilder(
        stream: _controller.streamAllExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              !snapshot.hasData ||
              !(snapshot.data?.success ?? false)) {
            return Center(child: Text("Error loading expenses"));
          }
          return SingleChildScrollView(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(12),
              itemBuilder: (context, index) {
                var data = snapshot.data!.data![index];
                return Container(
                  decoration: BoxDecorations.decorationWithShadow(
                    decColor: Colors.black.withValues(alpha: 0.8),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        getDateFormate(
                          DateTime.parse(data.date ?? ""),
                          "dd MMM yyyy",
                        ),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "₹ ${data.amount ?? 0}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemCount: snapshot.data!.data!.length,
            ),
          );
        },
      ),
    );
  }
}
