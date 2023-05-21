class DateModel {
  String? dateId;
  String? teacherId;
  String? dateDay;
  String? dateTime;
  String? datePer;
  String? teacherName;
  String? subjectName;
  String? dateCreate;

  DateModel(
      {this.dateId, this.teacherId, this.dateDay, this.dateTime, this.datePer});

  DateModel.fromJson(Map<String, dynamic> json) {
    dateId = json['date_id'];
    teacherId = json['teacher_id'];
    dateDay = json['date_day'];
    dateTime = json['date_time'];
    datePer = json['date_per'];
    teacherName = json['teacher_name'];
    subjectName = json['subject_name'];
    dateCreate = json['date_create'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date_id'] = dateId;
    data['teacher_id'] = teacherId;
    data['date_day'] = dateDay;
    data['date_time'] = dateTime;
    data['date_per'] = datePer;
    data['teacher_name'] = teacherName;
    data['subject_name'] = subjectName;
    data['date_create'] = dateCreate;
    return data;
  }
}