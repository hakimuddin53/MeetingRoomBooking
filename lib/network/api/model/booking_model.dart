import 'package:json_annotation/json_annotation.dart';
part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel extends Object {
  @JsonKey(name: 'month')
  int month;

  BookingModel(this.month);

  factory BookingModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BookingModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}

@JsonSerializable()
class BookingResponseModel extends Object {
  @JsonKey(name: 'booking')
  List<Booking> booking;

  @JsonKey(name: 'result_code')
  String resultCode;

  @JsonKey(name: 'result_description')
  String resultDescription;

  BookingResponseModel(
    this.booking,
    this.resultCode,
    this.resultDescription,
  );

  factory BookingResponseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BookingResponseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookingResponseModelToJson(this);
}

@JsonSerializable()
class Booking extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'meetingRoomName')
  String meetingRoomName;

  @JsonKey(name: 'date')
  int date;

  @JsonKey(name: 'month')
  int month;

  @JsonKey(name: 'userName')
  int userName;

  @JsonKey(name: 'title')
  int title;

  Booking(
    this.id,
    this.meetingRoomName,
    this.date,
    this.month,
    this.userName,
    this.title,
  );

  factory Booking.fromJson(Map<String, dynamic> srcJson) =>
      _$BookingFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
