// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) {
  return BookingModel(
    json['month'] as int,
  );
}

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'month': instance.month,
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
    json['id'] as int,
    json['meetingRoomName'] as String,
    json['date'] as int,
    json['month'] as int,
    json['userName'] as int,
    json['title'] as int,
  );
}

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'meetingRoomName': instance.meetingRoomName,
      'date': instance.date,
      'month': instance.month,
      'userName': instance.userName,
      'title': instance.title,
    };
