import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class DeleteLessonData {
  Crud crud;

  DeleteLessonData(this.crud);

  getDeleteLessonData({
    required String lessonId,
  }) async {
    var response = await crud.postData(
      AppLinks.deleteLesson,
      {
        'lesson_id': lessonId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}