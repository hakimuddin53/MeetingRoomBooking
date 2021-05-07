import 'package:json_annotation/json_annotation.dart';
part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel extends Object {
  @JsonKey(name: 'day')
  String day;

  @JsonKey(name: 'meetingRoom')
  String meetingRoom;

  BookingModel(this.day, this.meetingRoom);

  factory BookingModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BookingModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}

@JsonSerializable()
class BookingResponseModel extends Object {
  @JsonKey(name: 'timeSlot')
  TimeSlot timeSlot;

  @JsonKey(name: 'result_code')
  String resultCode;

  @JsonKey(name: 'result_description')
  String resultDescription;

  BookingResponseModel(
    this.timeSlot,
    this.resultCode,
    this.resultDescription,
  );

  factory BookingResponseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BookingResponseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookingResponseModelToJson(this);
}

@JsonSerializable()
class TimeSlot extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'meetingRoomName')
  String meetingRoomName;

  @JsonKey(name: 'tS_8_830')
  bool tS_8_830;

  @JsonKey(name: 'tS_830_9')
  bool tS_830_9;

  @JsonKey(name: 'tS_9_930')
  bool tS_9_930;

  @JsonKey(name: 'tS_930_10')
  bool tS_930_10;

  @JsonKey(name: 'tS_10_1030')
  bool tS_10_1030;

  @JsonKey(name: 'tS_1030_11')
  bool tS_1030_11;

  @JsonKey(name: 'tS_11_1130')
  bool tS_11_1130;

  @JsonKey(name: 'tS_1130_12')
  bool tS_1130_12;

  @JsonKey(name: 'tS_12_1230')
  bool tS_12_1230;

  @JsonKey(name: 'tS_1230_1')
  bool tS_1230_1;

  @JsonKey(name: 'tS_1_130')
  bool tS_1_130;

  @JsonKey(name: 'tS_130_2')
  bool tS_130_2;

  @JsonKey(name: 'tS_2_230')
  bool tS_2_230;

  @JsonKey(name: 'tS_230_3')
  bool tS_230_3;

  @JsonKey(name: 'tS_3_330')
  bool tS_3_330;

  @JsonKey(name: 'tS_330_4')
  bool tS_330_4;

  @JsonKey(name: 'tS_4_430')
  bool tS_4_430;

  @JsonKey(name: 'tS_430_5')
  bool tS_430_5;

  @JsonKey(name: 'tS_5_530')
  bool tS_5_530;

  @JsonKey(name: 'tS_530_6')
  bool tS_530_6;

  @JsonKey(name: 'tS_6_630')
  bool tS_6_630;

  @JsonKey(name: 'tS_630_7')
  bool tS_630_7;

  @JsonKey(name: 'tS_7_730')
  bool tS_7_730;

  @JsonKey(name: 'tS_730_8')
  bool tS_730_8;

  @JsonKey(name: 'bookings')
  List<Booking> bookings;

  @JsonKey(name: 'isActive')
  bool isActive;

  @JsonKey(name: 'createdDate')
  String createdDate;

  @JsonKey(name: 'createdBy')
  String createdBy;

  TimeSlot(
      this.id,
      this.date,
      this.meetingRoomName,
      this.tS_8_830,
      this.tS_830_9,
      this.tS_9_930,
      this.tS_930_10,
      this.tS_10_1030,
      this.tS_1030_11,
      this.tS_11_1130,
      this.tS_1130_12,
      this.tS_12_1230,
      this.tS_1230_1,
      this.tS_1_130,
      this.tS_130_2,
      this.tS_2_230,
      this.tS_230_3,
      this.tS_3_330,
      this.tS_330_4,
      this.tS_4_430,
      this.tS_430_5,
      this.tS_5_530,
      this.tS_530_6,
      this.tS_6_630,
      this.tS_630_7,
      this.tS_7_730,
      this.tS_730_8,
      this.bookings,
      this.isActive,
      this.createdDate,
      this.createdBy);

  factory TimeSlot.fromJson(Map<String, dynamic> srcJson) =>
      _$TimeSlotFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}

@JsonSerializable()
class Booking extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'timeSlotId')
  String timeSlotId;

  @JsonKey(name: 'userName')
  String userName;

  @JsonKey(name: 'timeSlotDescription')
  String timeSlotDescription;

  @JsonKey(name: 'department')
  String department;

  @JsonKey(name: 'isActive')
  bool isActive;

  @JsonKey(name: 'createdDate')
  String createdDate;

  @JsonKey(name: 'createdBy')
  String createdBy;

  Booking(
    this.id,
    this.timeSlotId,
    this.userName,
    this.timeSlotDescription,
    this.department,
    this.isActive,
    this.createdDate,
    this.createdBy,
  );

  factory Booking.fromJson(Map<String, dynamic> srcJson) =>
      _$BookingFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
