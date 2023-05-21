
class StudentLessonModel {
  String? studentId;
  String? studentMark;
  String? lessonId;
  String? studentDelay;

  StudentLessonModel(
      {this.studentId, this.studentMark, this.lessonId, this.studentDelay});

  StudentLessonModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    studentMark = json['student_mark'];
    lessonId = json['lesson_id'];
    studentDelay = json['student_delay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = studentId;
    data['student_mark'] = studentMark;
    data['lesson_id'] = lessonId;
    data['student_delay'] = studentDelay;
    return data;
  }
}