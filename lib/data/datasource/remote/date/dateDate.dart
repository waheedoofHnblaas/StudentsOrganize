import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class DateData {
  Crud crud;

  DateData(this.crud);

  dateData({
    required String teacherId,
  }) async {
    var response = await crud.postData(
      AppLinks.dateByTeacher,
      {
        'teacher_id': teacherId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
