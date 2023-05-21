import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class LoginInfoData {
  Crud crud;

  LoginInfoData(this.crud);

  loginInfoData({
    required String password,
  }) async {
    var response = await crud.postData(
      AppLinks.loginStudentLink,
      {
        'student_password': password,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
