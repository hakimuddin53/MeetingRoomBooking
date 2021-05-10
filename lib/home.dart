import 'package:abx_booking/model/meetingroom.dart';
import 'package:abx_booking/pages/basics_example.dart';
import 'package:abx_booking/pages/events_example.dart';
import 'package:flutter/material.dart';

import 'data/user_repo.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<MeetingRoom> meetingRooms = [
    MeetingRoom(
        name: 'Meeting Room - LEVEL 1A',
        meetingRoomImage: 'assets/images/abxexpress.png',
        description: "First Floor"),
    MeetingRoom(
        name: 'Meeting Room - LEVEL 1B',
        meetingRoomImage: 'assets/images/abxexpress.png',
        description: "First Floor"),
    MeetingRoom(
        name: 'Meeting Room - LEVEL 2A',
        meetingRoomImage: 'assets/images/abxexpress.png',
        description: "Second Floor"),
    MeetingRoom(
        name: 'Meeting Room - LEVEL 2B',
        meetingRoomImage: 'assets/images/abxexpress.png',
        description: "Second Floor"),
  ];

  Widget meetingRoomCard(MeetingRoom) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          setMeetingRoom(MeetingRoom.name.toString());

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) =>
          //             // TableBasicsExample(MeetingRoom.name.toString())));
          //             TableEventsExample()));

          Navigator.of(context).push(
            MaterialPageRoute(
              settings: RouteSettings(name: "/TableEvents"),
              builder: (context) => TableEventsExample(),
            ),
          );
        },
        child: Card(
          color: Colors.orangeAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage(MeetingRoom.meetingRoomImage)))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      MeetingRoom.name,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      MeetingRoom.description,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        //backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("Meeting Room"),
          backgroundColor: Colors.orange[800],
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          // leading: new IconButton(
          //   icon: new Icon(Icons.ac_unit),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Column(
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Icon(Icons.menu, size: 35, color: Colors.white),
              //     Text('Notifications',
              //       style: TextStyle (
              //           color: Colors.white,
              //           fontSize: 25
              //       ),
              //     ),
              //     Icon(Icons.notifications_none, size: 35, color: Colors.white)
              //   ],
              // ),
              Column(
                  children: meetingRooms.map((p) {
                return meetingRoomCard(p);
              }).toList())
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     //backgroundColor: Colors.grey[900],
  //     appBar: AppBar(
  //       title: Text("Meeting Room"),
  //       backgroundColor: Colors.orange[800],
  //       actions: <Widget>[
  //         PopupMenuButton<String>(
  //           onSelected: handleClick,
  //           itemBuilder: (BuildContext context) {
  //             return {'Logout', 'Settings'}.map((String choice) {
  //               return PopupMenuItem<String>(
  //                 value: choice,
  //                 child: Text(choice),
  //               );
  //             }).toList();
  //           },
  //         ),
  //       ],
  //     ),
  //     body: WillPopScope(
  //       onWillPop: _onWillPop,
  //       child: Padding(
  //         padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
  //         child: Column(
  //           children: <Widget>[
  //             // Row(
  //             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             //   children: <Widget>[
  //             //     Icon(Icons.menu, size: 35, color: Colors.white),
  //             //     Text('Notifications',
  //             //       style: TextStyle (
  //             //           color: Colors.white,
  //             //           fontSize: 25
  //             //       ),
  //             //     ),
  //             //     Icon(Icons.notifications_none, size: 35, color: Colors.white)
  //             //   ],
  //             // ),
  //             Column(
  //                 children: meetingRooms.map((p) {
  //                   return meetingRoomCard(p);
  //                 }).toList())
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Future<bool> _onWillPop() {
  //   Navigator.of(context).pop(false);
  //   return Future.value(false);
  // }
  //
  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        Navigator.of(context).pop();
        break;
    }
  }

  void setMeetingRoom(String name) async {
    await UserRepo().setMeetingRoom(name);
  }
}
