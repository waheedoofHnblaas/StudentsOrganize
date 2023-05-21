import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class DeleteStudentLessonsData {
  Crud crud;

  DeleteStudentLessonsData(this.crud);

  getStudentLessonsData({
    required String studentId,
    required String dateId,
    required String teacherId,
  }) async {
    var response = await crud.postData(
      AppLinks.deleteStudentLessons,
      {
        'student_id': studentId,
        'date_id': dateId,
        'teacher_id': teacherId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}