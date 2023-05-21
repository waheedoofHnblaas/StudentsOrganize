

import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class AddDateData {
  Crud crud;

  AddDateData(this.crud);

  addDateData({
    required String teacherId,
    required String dateDay,
    required String dateTime,
    required String datePer,
  }) async {
    var response = await crud.postData(
      AppLinks.addDate,
      {
        'teacher_id': teacherId,
        'date_day': dateDay,
        'date_time': dateTime,
        'date_per': datePer,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
