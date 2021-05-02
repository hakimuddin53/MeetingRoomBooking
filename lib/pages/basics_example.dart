// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../addevent.dart';
import '../utils.dart';


class TableBasicsExample extends StatefulWidget {
  final String name;

  TableBasicsExample(this.name){
    print(name);
  }

  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
        backgroundColor: Colors.orange[800],
      ),
      body:

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

      Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Text(
          widget.name,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
    ),
      TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
        ],
    ),

    floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add),
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => CustomTimePickerDemo())); }
        ),

       // Row(
       //      crossAxisAlignment: CrossAxisAlignment.end,
       //      children: [
       //        Padding(
       //          padding: const EdgeInsets.only(left:100.0),
       //          child: FloatingActionButton(
       //            onPressed: () {
       //              // Add your onPressed code here!
       //            },
       //            child: Icon(Icons.message,color: Colors.white,),
       //            backgroundColor: Colors.green,
       //          ),
       //        ),
       //      ],
       //    ),


    );
  }
}
