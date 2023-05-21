



import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class AddLessonData {
  Crud crud;

  AddLessonData(this.crud);

  addLessonData({
    required String studentId,
    required String teacherId,
    required String dateId,
    required String lessonNote,
    required String lessonIsExam,
    required String lessonLate,
    required String lessonMark,
  }) async {
    var response = await crud.postData(
      AppLinks.addLesson,
      {
        'student_id': studentId,
        'teacher_id': teacherId,
        'date_id': dateId,
        'lesson_note': lessonNote,
        'lesson_isExam': lessonIsExam,
        'lesson_late': lessonLate,
        'lesson_mark': lessonMark,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}


