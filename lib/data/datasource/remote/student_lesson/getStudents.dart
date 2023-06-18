import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class StudentsLessonData {
  Crud crud;

  StudentsLessonData(this.crud);

  studentsLessonData({
    required String lessonId,
  }) async {
    var response = await crud.postData(
      AppLinks.getStudentsLink,
      {
        'lesson_id': lessonId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

}
