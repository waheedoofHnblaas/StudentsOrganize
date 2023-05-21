

import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class StudentDateData {
  Crud crud;

  StudentDateData(this.crud);

  getStudentDate({
    required String dateId
  }) async {
    var response = await crud.postData(
      AppLinks.getStudentsDate,
      {
        'date_id': dateId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
