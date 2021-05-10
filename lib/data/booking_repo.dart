import 'package:abx_booking/data/result.dart';
import 'package:abx_booking/data/user_repo.dart';
import 'package:abx_booking/network/api/api.dart';
import 'package:abx_booking/network/api/model/booking_model.dart';
import 'package:uuid/uuid.dart';
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
        return Result(true, data: response.booking);
      } else {
        return Result(false, message: response.resultDescription);
      }
    } catch (exception, stackTrace) {
      return handleError(exception, stackTrace);
    }
  }

  Future<Result> insertNewBooking(
      String selectedDay,
      String selectedStartTime,
      String selectedEndTime,
      String selectedStartTimeDescription,
      String selectedEndTimeDescription,
      String department,
      String createdDate) async {
    try {
      var meetingRoom = await UserRepo().getMeetingRoom();
      var userName = await UserRepo().getUserName();
      // Create uuid object
      var uuid = Uuid();
      var params = Booking(
          uuid.v1(),
          selectedDay,
          meetingRoom,
          userName,
          selectedStartTime,
          selectedEndTime,
          selectedStartTimeDescription,
          selectedEndTimeDescription,
          department,
          true,
          createdDate,
          userName);

      LoginResponseModel response =
          await Api.getInstance().insertBooking(params);

      if (response.resultCode == "200") {
        return Result(true, data: response.message);
      } else {
        return Result(false, message: response.resultDescription);
      }
    } catch (exception, stackTrace) {
      return handleError(exception, stackTrace);
    }
  }
}
