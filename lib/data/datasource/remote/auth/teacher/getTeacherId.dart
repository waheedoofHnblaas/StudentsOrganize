
import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class TeacherData {
  Crud crud;

  TeacherData(this.crud);

  getTeacherData({
    required String teacherId,
  }) async {
    var response = await crud.postData(
      AppLinks.getTeacherById,
      {
        'teacher_id': teacherId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
