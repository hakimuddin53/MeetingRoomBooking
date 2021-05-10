import 'package:abx_booking/pages/events_example.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'components/custom_snackbar.dart';

import 'package:abx_booking/data/booking_repo.dart';
import 'base_page_state.dart';
import 'data/result.dart';

class CustomTimePickerDemo extends StatefulWidget {
  final DateTime? _selectedDay;
  CustomTimePickerDemo(this._selectedDay);

  @override
  _CustomTimePickerDemoState createState() => _CustomTimePickerDemoState();
}

class _CustomTimePickerDemoState extends BasePageState<CustomTimePickerDemo> {
  TimeOfDay selectedStartTime = TimeOfDay(hour: 8, minute: 00);
  TimeOfDay selectedEndTime = TimeOfDay(hour: 9, minute: 00);

  late String _department;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _selectStartTime() async {
      final TimeOfDay newTime = (await showTimePicker(
        context: context,
        initialTime: selectedStartTime,
      ))!;
      setState(() {
        selectedStartTime = newTime;
      });
    }

    void _selectEndTime() async {
      final TimeOfDay newTime = (await showTimePicker(
        context: context,
        initialTime: selectedEndTime,
      ))!;
      setState(() {
        selectedEndTime = newTime;
      });
    }

    final DateFormat formatter = DateFormat('dd MMMM, yyyy');
    final String _selectedDayDisplay = formatter.format(widget._selectedDay!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Booking Time'),
        backgroundColor: Colors.orange[800],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Department Name',
                ),
                validator: (val) {
                  if (val!.length == 0)
                    return "Please enter department name";
                  else
                    return null;
                },
                onSaved: (val) => _department = val!,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child:
                    Text(_selectedDayDisplay, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InkWell(
                  onTap: () => setState(() {
                    _selectStartTime();
                  }),
                  child: Text(
                    selectedStartTime.format(context),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child:
                    Text(_selectedDayDisplay, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InkWell(
                  onTap: () => setState(() {
                    _selectEndTime();
                  }),
                  child: Text(
                    selectedEndTime.format(context),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //     color: Colors.orange,
                  //     borderRadius: BorderRadius.circular(20)),

                  margin: const EdgeInsets.symmetric(
                    horizontal: 0.0,
                    vertical: 40.0,
                  ),

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      //add method for insert data and call api
                      _insertNewBooking();
                    },

                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),

                    // child: Text(
                    //   'Save',
                    //   style: TextStyle(color: Colors.white, fontSize: 25),
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _insertNewBooking() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showLoadingView(true);
      FocusScope.of(context).requestFocus(FocusNode());

      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final DateFormat formatterNow = DateFormat('yyyy-MM-dd HH:mm:ss');

      var format = "";
      if (selectedStartTime.format(context).contains("AM") ||
          selectedStartTime.format(context).contains("PM")) {
        format = 'yyyy-MM-dd hh:mm a';
      } else {
        format = 'yyyy-MM-dd HH:mm';
      }

      String selectedStartDateTime = formatter.format(widget._selectedDay!) +
          " " +
          selectedStartTime.format(context); //'July 7,2020 10:00 AM';
      DateFormat selectedStartDateTimeFormat = DateFormat(format);

      String selectedEndDateTime = formatter.format(widget._selectedDay!) +
          " " +
          selectedEndTime.format(context); //'July 7,2020 10:00 AM';
      DateFormat selectedEndDateTimeFormat = DateFormat(format);

      if (selectedStartDateTimeFormat
          .parse(selectedStartDateTime)
          .isAfter(selectedEndDateTimeFormat.parse(selectedEndDateTime))) {
        CustomSnackbar().show(
            context,
            "The Start Time is after End Time! Please change the Time and try again!",
            MessageType.ERROR);
        return;
      }

      Result result = await BookingRepo().insertNewBooking(
          formatter.format(widget._selectedDay!),
          formatterNow
              .format(selectedStartDateTimeFormat.parse(selectedStartDateTime)),
          formatterNow
              .format(selectedEndDateTimeFormat.parse(selectedEndDateTime)),
          selectedStartTime.format(context),
          selectedEndTime.format(context),
          _department,
          formatterNow.format(DateTime.now()));

      if (result.isSuccess) {
        if (result.data == "Time Slot Not Available") {
          CustomSnackbar().show(
              context,
              "The following time slot is not available! Please choose another Time Slot!",
              MessageType.ERROR);
        } else {
          // Navigator.of(context).pop();
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (_) => TableEventsExample()));

          Navigator.of(context).push(
            MaterialPageRoute(
              settings: RouteSettings(name: "/TableEventsExample"),
              builder: (context) => TableEventsExample(),
            ),
          );
        }
      } else {
        CustomSnackbar().show(
            context,
            "Booking Insertion Failed!! Please try again later!",
            MessageType.ERROR);
      }
      showLoadingView(false);
    }
  }
}
