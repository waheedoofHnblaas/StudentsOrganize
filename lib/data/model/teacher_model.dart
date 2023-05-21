class TeacherModel {
  String? teacherId;
  String? teacherName;
  String? teacherPassword;
  String? teacherCreate;
  String? subjectId;
  String? teacherPhone;

  TeacherModel(
      {this.teacherId,
        this.teacherName,
        this.teacherPassword,
        this.teacherCreate,
        this.subjectId,
        this.teacherPhone});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacher_id'];
    teacherName = json['teacher_name'];
    teacherPassword = json['teacher_password'];
    teacherCreate = json['teacher_create'];
    subjectId = json['subject_id'];
    teacherPhone = json['teacher_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teacher_id'] = teacherId;
    data['teacher_name'] = teacherName;
    data['teacher_password'] = teacherPassword;
    data['teacher_create'] = teacherCreate;
    data['subject_id'] = subjectId;
    data['teacher_phone'] = teacherPhone;
    return data;
  }
}