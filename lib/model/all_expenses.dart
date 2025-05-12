class AllExpenses {
  List<Data>? data;
  bool? success;

  AllExpenses({this.data, this.success});

  AllExpenses.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? date;
  String? name;
  int? amount;

  Data({this.date, this.name, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    name = json['name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}
