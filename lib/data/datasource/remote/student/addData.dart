import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class AddStudentData {
  Crud crud;

  AddStudentData(this.crud);

  addStudentData({
    required String studentName,
    required String studentPassword,
    required String studentPhone,
  }) async {
    var response = await crud.postData(
      AppLinks.addStudent,
      {
        'student_name': studentName,
        'student_password': studentPassword,
        'student_phone': studentPhone,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
