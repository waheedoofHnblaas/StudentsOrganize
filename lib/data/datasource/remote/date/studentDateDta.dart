
import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class StudentDateData {
  Crud crud;

  StudentDateData(this.crud);

  studentDateData({
    required String studentId,
  }) async {
    var response = await crud.postData(
      AppLinks.studentDateLink,
      {
        'student_id': studentId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
