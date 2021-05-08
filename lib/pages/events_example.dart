import 'dart:collection';

import 'package:abx_booking/data/booking_repo.dart';
import 'package:abx_booking/data/result.dart';
import 'package:abx_booking/data/user_repo.dart';
import 'package:abx_booking/network/api/model/booking_model.dart';
import 'package:abx_booking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../addevent.dart';
import '../base_page_state.dart';

class TableEventsExample extends StatefulWidget {
  final String name;

  TableEventsExample(this.name);

  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends BasePageState<TableEventsExample> {
  late ValueNotifier<List<Booking>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  var kEventsBooking = LinkedHashMap<DateTime, List<Booking>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void initState() {
    super.initState();

    setMeetingRoom(widget.name);

    _selectedDay = _focusedDay;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadDataForPage();
    });
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
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
    showLoadingView(true);
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

      showLoadingView(false);
    } else {
      showLoadingView(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Events'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.name,
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          TableCalendar<Booking>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
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
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index].userName}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orangeAccent,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CustomTimePickerDemo(_selectedDay)));
          }),
    );
  }
}

// for (DateTime indexDay = DateTime(this.year, this.month, 1);
//     indexDay.month == this.month;
//     indexDay = indexDay.add(Duration(days: 1))) {
//   print(indexDay.toString());
// }

// _getEventsForDay(_selectedDay!);
// _selectedEvents = ValueNotifier(_eventList);

// final DateFormat formatter = DateFormat('yyyy-MM-dd');
// final String formatted = formatter.format(day);
// _loadDataFromAPI(formatted, day);

// final DateFormat formatter = DateFormat('yyyy-MM-dd');
// final String formatted = formatter.format(day);
// _loadDataFromAPI(formatted, day);

// if (kEventsBooking[day] != null) {
//   kEventsBooking[day]!.addAll(_eventListDay);
// } else {
//   kEventsBooking[day] = [_eventListDay.single];
// }

// List<Booking> newEventFromApi = [];
//
// showLoadingView(true);
// Result resultApi = BookingRepo().booking(month);
// if (resultApi.isSuccess) {
//   newEventFromApi = resultApi.data;
//   _eventList.addAll(newEventFromApi);
//   // setState(() {
//   //   _eventList.addAll(newEventFromApi);
//   // });
//
//   showLoadingView(false);
// } else {
//   showLoadingView(false);
// }

// showLoadingView(true);
// Result resultApi = await BookingRepo().booking(5);
//
// if (resultApi.isSuccess) {
//   List<Booking> newEventFromApi = resultApi.data;
//
//   // setState(() {
//   //   _eventList.addAll(newEventFromApi);
//   // });
//
//   _eventList.addAll(_loadDataFromAPI(5));
//
//   kEventsBooking.addAll({
//     // DateTime.utc(2020, 10, item * 4)
//     day: _eventList
//   });
//
//   showLoadingView(false);
// } else {
//   showLoadingView(false);
// }
//
// var kEvents1 = LinkedHashMap<DateTime, List<Booking>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll({
//     // DateTime.utc(2020, 10, item * 4)
//     DateTime.parse("2021-04-01 13:01:01"): [
//       Booking(
//         1,
//       ),
//       Booking('Today\'s Event 2'),
//     ],
//   });

//return kEventsBooking[day] ?? [];

// _eventListDay.add(resultApi.data);

// setState(() {
//   _eventList.addAll(newEventFromApi);
// });
