import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class DeleteDateData {
  Crud crud;

  DeleteDateData(this.crud);

  getDeleteDateData({
    required String dateId,
    required String teacherId,
  }) async {
    var response = await crud.postData(
      AppLinks.deleteDate,
      {
        'date_id': dateId,
        'teacher_id': teacherId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}