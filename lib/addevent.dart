import 'package:flutter/material.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Show Custom Time Picker Demo',
      home: CustomTimePickerDemo(),
    );
  }
}

class CustomTimePickerDemo extends StatefulWidget {
  @override
  _CustomTimePickerDemoState createState() => _CustomTimePickerDemoState();
}

class _CustomTimePickerDemoState extends State<CustomTimePickerDemo> {
  String selectedTime;

  List<int> _availableHours = [9, 10,11, 12, 13,14,15,16,17,18];
  List<int> _availableMinutes = [0];

  @override
  Widget build(BuildContext context) => Scaffold(
    body:
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: InkWell(
              onTap: () =>
              // DEMO --------------
              showCustomTimePicker(
                  context: context,
                  onFailValidation: (context) =>
                      showMessage(context, 'Unavailable selection.'),
                  initialTime: TimeOfDay(
                      hour: _availableHours.first,
                      minute: _availableMinutes.first),
                  selectableTimePredicate: (time) =>
                  _availableHours.indexOf(time.hour) != -1 &&
                      _availableMinutes.indexOf(time.minute) != -1).then(
                      (time) =>
                      setState(() => selectedTime = time.format(context).toString())),
              // --------------

              child: Text(
                selectedTime ?? 'Select Time',
                //style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ),
          ),

  ],
    ),
  );

  showMessage(BuildContext context, String message) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 16,
              ),
              Icon(
                Icons.warning,
                color: Colors.amber,
                size: 56,
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF231F20),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      border:
                      Border(top: BorderSide(color: Color(0xFFE8ECF3)))),
                  child: Text(
                    'Error',
                    style: TextStyle(
                        color: Color(0xFF2058CA),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}