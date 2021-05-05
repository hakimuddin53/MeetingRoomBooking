import 'package:abx_booking/data/result.dart';
import 'package:abx_booking/data/user_repo.dart';
import 'package:abx_booking/network/api/api.dart';
import 'package:abx_booking/network/api/model/login_model.dart';

import 'base_repo.dart';

class AuthRepo extends BaseRepo {
  static const String kVerifiedUsers = "VERIFIED_USERS";

  Future<Result> login(String userName, String password) async {
    try {
      InfoLoginInput info = new InfoLoginInput(userName, password);
      LoginModel params = LoginModel(info, "v1.0.0");
      LoginResponseModel response = await Api.getInstance().appLogin(params);

      if (response.resultCode == "200") {
        await UserRepo().setUserName(userName);
        await UserRepo().setUserPassword(password);

        return Result(true, data: response);
      } else {
        return Result(false, message: response.resultDescription);
      }
    } catch (exception, stackTrace) {
      return handleError(exception, stackTrace);
    }
  }
}
