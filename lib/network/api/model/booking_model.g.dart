// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) {
  return BookingModel(
    json['day'] as String,
    json['meetingRoom'] as String,
  );
}

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'meetingRoom': instance.meetingRoom,
    };

BookingResponseModel _$BookingResponseModelFromJson(Map<String, dynamic> json) {
  return BookingResponseModel(
    (json['booking'] as List<dynamic>)
        .map((e) => Booking.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['result_code'] as String,
    json['result_description'] as String,
  );
}

Map<String, dynamic> _$BookingResponseModelToJson(
        BookingResponseModel instance) =>
    <String, dynamic>{
      'booking': instance.booking,
      'result_code': instance.resultCode,
      'result_description': instance.resultDescription,
    };

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return Booking(
    json['id'] as String,
    json['date'] as String,
    json['meetingRoomName'] as String,
    json['userName'] as String,
    json['startTime'] as String,
    json['endTime'] as String,
    json['startTimeDescription'] as String,
    json['endTimeDescription'] as String,
    json['department'] as String,
    json['isActive'] as bool,
    json['createdDate'] as String,
    json['createdBy'] as String,
  );
}

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'meetingRoomName': instance.meetingRoomName,
      'userName': instance.userName,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'startTimeDescription': instance.startTimeDescription,
      'endTimeDescription': instance.endTimeDescription,
      'department': instance.department,
      'isActive': instance.isActive,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
    };
