import 'package:abx_booking/data/result.dart';
import 'package:abx_booking/data/user_repo.dart';
import 'package:abx_booking/network/api/api.dart';
import 'package:abx_booking/network/api/model/booking_model.dart';
import 'package:abx_booking/network/api/model/login_model.dart';

import 'base_repo.dart';

class BookingRepo extends BaseRepo {
  static const String kVerifiedUsers = "VERIFIED_USERS";

  Future<Result> booking(String day) async {
    try {
      var meetingRoom = await UserRepo().getMeetingRoom();
      var params = BookingModel(day, meetingRoom);

      BookingResponseModel response =
          await Api.getInstance().getBooking(params);

      if (response.resultCode == "200") {
        return Result(true, data: response.timeSlot);
      } else {
        return Result(false, message: response.resultDescription);
      }
    } catch (exception, stackTrace) {
      return handleError(exception, stackTrace);
    }
  }
}
