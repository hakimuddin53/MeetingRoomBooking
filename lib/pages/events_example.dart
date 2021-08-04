import 'dart:collection';

import 'package:abx_booking/components/abx/table_calendar.dart';
import 'package:abx_booking/components/custom_snackbar.dart';
import 'package:abx_booking/data/booking_repo.dart';
import 'package:abx_booking/data/result.dart';
import 'package:abx_booking/data/user_repo.dart';
import 'package:abx_booking/network/api/model/booking_model.dart';
import 'package:abx_booking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../addevent.dart';
import '../base_page_state.dart';

class TableEventsExample extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends BasePageState<TableEventsExample> {
  late ValueNotifier<List<Booking>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String meetingRoomName = "";

  var kEventsBooking = LinkedHashMap<DateTime, List<Booking>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void initState() {
    super.initState();

    getMeetingRoom();

    _selectedDay = _focusedDay;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadDataForPage();
    });
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  Future<void> getMeetingRoom() async {
    meetingRoomName = await UserRepo().getMeetingRoom();
  }

  void setMeetingRoom(String name) async {
    await UserRepo().setMeetingRoom(name);
  }

  void _loadDataForPage() {
    var datetimeList = daysInRange(iFirstDay, iLastDay);

    datetimeList.forEach((element) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(element);
      _loadDataFromAPI(formatted, element);
    });
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Booking> _getEventsForDay(DateTime day) {
    return kEventsBooking[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      // _getEventsForDay(selectedDay);
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _loadDataFromAPI(String day, DateTime date) async {
    super.showLoadingView(true);
    Result resultApi = await BookingRepo().booking(day);
    if (resultApi.isSuccess) {
      kEventsBooking.addAll({
        // DateTime.utc(2020, 10, item * 4)
        date: resultApi.data
      });

      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(DateTime.now());

      if (day == formatted) {
        _selectedEvents = ValueNotifier(_getEventsForDay(date));
      }

      super.showLoadingView(false);
    } else {
      super.showLoadingView(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Day'),
        backgroundColor: Colors.orange[800],
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    meetingRoomName,
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
                TableCalendar<dynamic>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarBuilders: calendarBuilder(),
                  calendarStyle: CalendarStyle(
                    // Use `CalendarStyle` to customize the UI
                    outsideDaysVisible: true,
                  ),
                  onDaySelected: _onDaySelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ValueListenableBuilder<List<Booking>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            // decoration: BoxDecoration(
                            //   border: Border.all(),
                            //   borderRadius: BorderRadius.circular(12.0),
                            // ),
                            child: ListTile(
                              onTap: () => {
                                //_deleteBooking(value[index], value, index),
                              },
                              title: Row(
                                children: <Widget>[
                                  Text(
                                    '${value[index].userName}',
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                      child: Text(
                                    '${value[index].startTimeDescription}' +
                                        " - " +
                                        '${value[index].endTimeDescription}',
                                    textAlign: TextAlign.right,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  InkWell(
                                    onTap: () => {
                                      _deleteBooking(
                                          value[index], value, index),
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          bottom: 0,
                                          top: 0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Text('${value[index].userName}'),
                              subtitle: Text('${value[index].department}'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(right: 10.0, bottom: 20, top: 10),
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          // test();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              settings:
                                  RouteSettings(name: "/CustomTimePickerDemo"),
                              builder: (context) =>
                                  CustomTimePickerDemo(_selectedDay),
                            ),
                          );

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => MyHome()));
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            super.loadingWidget
          ],
        ),
      ),
    );
  }

  void _deleteBooking(
      Booking booking, List<Booking> bookingList, int index) async {
    super.showLoadingView(true);
    FocusScope.of(context).requestFocus(FocusNode());

    Result result = await BookingRepo().deleteBooking(booking);

    if (result.isSuccess) {
      if (result.data == "UserName Not Same") {
        CustomSnackbar().show(
            context,
            "Can only delete the booking which was created by you!!",
            MessageType.ERROR);
      } else {
        bookingList.removeAt(index);

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     settings: RouteSettings(name: "/TableEventsExample"),
        //     builder: (context) => TableEventsExample(),
        //   ),
        // );
      }
    } else {
      CustomSnackbar().show(
          context, "Delete Failed!! Please try again!", MessageType.ERROR);
    }

    super.showLoadingView(false);
  }

  CalendarBuilders calendarBuilder() {
    return CalendarBuilders(
      markerBuilder: (context, date, events) {
        final children = <Widget>[];
        if (events.isNotEmpty) {
          children.add(
            Positioned(
              bottom: 1,
              child: _buildEventsMarkerNum(events),
            ),
          );
        } else {
          children.add(
            Positioned(
              bottom: 1,
              child: SizedBox.shrink(),
            ),
          );
        }
        return children.single;
      },
    );
  }

  Future<bool> _onWillPop() {
    // Navigator.popUntil(context, ModalRoute.withName("/MyHome"));

    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName + 'MyHome'));
    return Future.value(false);
  }
}

Widget _buildEventsMarkerNum(List events) {
  return buildCalendarDayMarker(
      text: '${events.length}', backColor: Colors.orange);
}

AnimatedContainer buildCalendarDayMarker({
  required String text,
  required Color backColor,
}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backColor,
    ),
    width: 52,
    height: 13,
    child: Center(
      child: Text(
        text,
        style: TextStyle().copyWith(
          color: Colors.white,
          fontSize: 10.0,
        ),
      ),
    ),
  );
}
