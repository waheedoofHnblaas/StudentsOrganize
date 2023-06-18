

class BayModel {
  String? bayId;
  String? bayDate;
  String? quantity;
  String? studentId;

  BayModel({this.bayId, this.bayDate, this.quantity, this.studentId});

  BayModel.fromJson(Map<String, dynamic> json) {
    bayId = json['bay_id'];
    bayDate = json['bay_date'];
    quantity = json['quantity'];
    studentId = json['student_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bay_id'] = bayId;
    data['bay_date'] = bayDate;
    data['quantity'] = quantity;
    data['student_id'] = studentId;
    return data;
  }
}