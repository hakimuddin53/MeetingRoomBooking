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
    TimeSlot.fromJson(json['timeSlot'] as Map<String, dynamic>),
    json['result_code'] as String,
    json['result_description'] as String,
  );
}

Map<String, dynamic> _$BookingResponseModelToJson(
        BookingResponseModel instance) =>
    <String, dynamic>{
      'timeSlot': instance.timeSlot,
      'result_code': instance.resultCode,
      'result_description': instance.resultDescription,
    };

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) {
  return TimeSlot(
    json['id'] as String,
    json['date'] as String,
    json['meetingRoomName'] as String,
    json['tS_8_830'] as bool,
    json['tS_830_9'] as bool,
    json['tS_9_930'] as bool,
    json['tS_930_10'] as bool,
    json['tS_10_1030'] as bool,
    json['tS_1030_11'] as bool,
    json['tS_11_1130'] as bool,
    json['tS_1130_12'] as bool,
    json['tS_12_1230'] as bool,
    json['tS_1230_1'] as bool,
    json['tS_1_130'] as bool,
    json['tS_130_2'] as bool,
    json['tS_2_230'] as bool,
    json['tS_230_3'] as bool,
    json['tS_3_330'] as bool,
    json['tS_330_4'] as bool,
    json['tS_4_430'] as bool,
    json['tS_430_5'] as bool,
    json['tS_5_530'] as bool,
    json['tS_530_6'] as bool,
    json['tS_6_630'] as bool,
    json['tS_630_7'] as bool,
    json['tS_7_730'] as bool,
    json['tS_730_8'] as bool,
    (json['bookings'] as List<dynamic>)
        .map((e) => Booking.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['isActive'] as bool,
    json['createdDate'] as String,
    json['createdBy'] as String,
  );
}

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'meetingRoomName': instance.meetingRoomName,
      'tS_8_830': instance.tS_8_830,
      'tS_830_9': instance.tS_830_9,
      'tS_9_930': instance.tS_9_930,
      'tS_930_10': instance.tS_930_10,
      'tS_10_1030': instance.tS_10_1030,
      'tS_1030_11': instance.tS_1030_11,
      'tS_11_1130': instance.tS_11_1130,
      'tS_1130_12': instance.tS_1130_12,
      'tS_12_1230': instance.tS_12_1230,
      'tS_1230_1': instance.tS_1230_1,
      'tS_1_130': instance.tS_1_130,
      'tS_130_2': instance.tS_130_2,
      'tS_2_230': instance.tS_2_230,
      'tS_230_3': instance.tS_230_3,
      'tS_3_330': instance.tS_3_330,
      'tS_330_4': instance.tS_330_4,
      'tS_4_430': instance.tS_4_430,
      'tS_430_5': instance.tS_430_5,
      'tS_5_530': instance.tS_5_530,
      'tS_530_6': instance.tS_530_6,
      'tS_6_630': instance.tS_6_630,
      'tS_630_7': instance.tS_630_7,
      'tS_7_730': instance.tS_7_730,
      'tS_730_8': instance.tS_730_8,
      'bookings': instance.bookings,
      'isActive': instance.isActive,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
    };

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return Booking(
    json['id'] as String,
    json['timeSlotId'] as String,
    json['userName'] as String,
    json['timeSlotDescription'] as String,
    json['department'] as String,
    json['isActive'] as bool,
    json['createdDate'] as String,
    json['createdBy'] as String,
  );
}

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'timeSlotId': instance.timeSlotId,
      'userName': instance.userName,
      'timeSlotDescription': instance.timeSlotDescription,
      'department': instance.department,
      'isActive': instance.isActive,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
    };
