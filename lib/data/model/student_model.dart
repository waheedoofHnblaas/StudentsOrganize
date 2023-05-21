
class StudentModel {
  String? studentId;
  String? studentName;
  String? studentPassword;
  String? studentCreate;
  String? studentPhone;

  StudentModel(
      {this.studentId,
        this.studentName,
        this.studentPassword,
        this.studentCreate,
        this.studentPhone});

  StudentModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    studentName = json['student_name'];
    studentPassword = json['student_password'];
    studentCreate = json['student_create'];
    studentPhone = json['student_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['student_name'] = this.studentName;
    data['student_password'] = this.studentPassword;
    data['student_create'] = this.studentCreate;
    data['student_phone'] = this.studentPhone;
    return data;
  }
}