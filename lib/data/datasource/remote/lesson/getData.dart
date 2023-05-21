

import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class GetLessonData {
  Crud crud;

  GetLessonData(this.crud);

  getLessonData({
    required String studentId,
    required String teacherId,
    required String dateId
  }) async {
    var response = await crud.postData(
      AppLinks.getStudentsLesson,
      {
        'student_id': studentId,
        'teacher_id': teacherId,
        'date_id': dateId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
