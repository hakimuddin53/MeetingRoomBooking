// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../addevent.dart';
// import '../utils/utils.dart';
//
// class TableBasicsExample extends StatefulWidget {
//   final String name;
//
//   TableBasicsExample(this.name) {
//     print(name);
//   }
//
//   @override
//   _TableBasicsExampleState createState() => _TableBasicsExampleState();
// }
//
// class _TableBasicsExampleState extends State<TableBasicsExample> {
//   // final ValueNotifier<List<Event>> _selectedEvents;
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   late DateTime _selectedDay = DateTime.now();
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //
//   //   _selectedDay = _focusedDay;
//   //   _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//   // }
//   //
//   // @override
//   // void dispose() {
//   //   _selectedEvents.dispose();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final titles = [
//       'bike',
//       'boat',
//       'bus',
//       'car',
//       'railway',
//       'run',
//       'subway',
//       'transit',
//       'walk'
//     ];
//
//     final icons = [
//       Icons.directions_bike,
//       Icons.directions_boat,
//       Icons.directions_bus,
//       Icons.directions_car,
//       Icons.directions_railway,
//       Icons.directions_run,
//       Icons.directions_subway,
//       Icons.directions_transit,
//       Icons.directions_walk
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Booking'),
//         backgroundColor: Colors.orange[800],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               child: Text(
//                 widget.name,
//                 style: TextStyle(color: Colors.black, fontSize: 24),
//               ),
//             ),
//             Container(
//               height: 400,
//               child: TableCalendar(
//                 firstDay: kFirstDay,
//                 lastDay: kLastDay,
//                 focusedDay: _focusedDay,
//                 calendarFormat: _calendarFormat,
//                 selectedDayPredicate: (day) {
//                   // Use `selectedDayPredicate` to determine which day is currently selected.
//                   // If this returns true, then `day` will be marked as selected.
//
//                   // Using `isSameDay` is recommended to disregard
//                   // the time-part of compared DateTime objects.
//                   return isSameDay(_selectedDay, day);
//                 },
//                 onDaySelected: (selectedDay, focusedDay) {
//                   if (!isSameDay(_selectedDay, selectedDay)) {
//                     // Call `setState()` when updating the selected day
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                     });
//                   }
//                 },
//                 onFormatChanged: (format) {
//                   if (_calendarFormat != format) {
//                     // Call `setState()` when updating calendar format
//                     setState(() {
//                       _calendarFormat = format;
//                     });
//                   }
//                 },
//                 onPageChanged: (focusedDay) {
//                   // No need to call `setState()` here
//                   _focusedDay = focusedDay;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 200, // constrain height
//               child: ListView.builder(
//                 itemCount: titles.length,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     //                           <-- Card widget
//                     child: ListTile(
//                       leading: Icon(icons[index]),
//                       title: Text(titles[index]),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.orangeAccent,
//           child: Icon(Icons.add),
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (_) => CustomTimePickerDemo()));
//           }),
//     );
//   }
// }
