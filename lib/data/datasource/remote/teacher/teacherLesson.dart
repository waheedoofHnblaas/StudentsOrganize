import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class TeacherLessonData {
  Crud crud;

  TeacherLessonData(this.crud);

  teacherLessonData({
    required String teacherId,
  }) async {
    var response = await crud.postData(
      AppLinks.getTeacherLessonLink,
      {
        'teacher_id': teacherId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
