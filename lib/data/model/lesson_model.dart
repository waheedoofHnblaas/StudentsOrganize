class LessonModel {
  String? lessonId;
  String? studentId;
  String? lessonCreate;
  String? lessonNote;
  String? lessonIsExam;
  String? lessonLate;
  String? lessonMark;

  LessonModel(
      {this.lessonId,
        this.studentId,
        this.lessonCreate,
        this.lessonNote,
        this.lessonIsExam,
        this.lessonLate,
        this.lessonMark});

  LessonModel.fromJson(Map<String, dynamic> json) {
    lessonId = json['lesson_id'];
    studentId = json['student_id'];
    lessonCreate = json['lesson_create'];
    lessonNote = json['lesson_note'];
    lessonIsExam = json['lesson_isExam'];
    lessonLate = json['lesson_late'];
    lessonMark = json['lesson_mark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lesson_id'] = this.lessonId;
    data['student_id'] = this.studentId;
    data['lesson_create'] = this.lessonCreate;
    data['lesson_note'] = this.lessonNote;
    data['lesson_isExam'] = this.lessonIsExam;
    data['lesson_late'] = this.lessonLate;
    data['lesson_mark'] = this.lessonMark;
    return data;
  }
}