import 'package:abx_booking/model/meetingroom.dart';
import 'package:abx_booking/pages/basics_example.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(
//   home: MyHome(),
// ));
//

class MyHome extends StatefulWidget {

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  List<MeetingRoom> meetingRooms = [
    MeetingRoom(name: 'Meeting Room A', meetingRoomImage: 'assets/images/flutter-logo.png', description: "First Floor"),
    MeetingRoom(name: 'Meeting Room B', meetingRoomImage: 'assets/images/flutter-logo.png', description: "Second Floor"),
    MeetingRoom(name: 'Meeting Room C', meetingRoomImage: 'assets/images/flutter-logo.png', description: "Third Floor"),
    MeetingRoom(name: 'Meeting Room D', meetingRoomImage: 'assets/images/flutter-logo.png', description: "Fourth Floor"),
  ];

  Widget meetingRoomCard(MeetingRoom) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child:
      InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => TableBasicsExample( MeetingRoom.name.toString())));
      },
      child : Card(
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
                            image: AssetImage(MeetingRoom.meetingRoomImage)
                        )
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(MeetingRoom.name,
                    style: TextStyle (
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                  Text(MeetingRoom.description,
                    style: TextStyle (
                        color: Colors.white,
                        fontSize: 12
                    ),
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

  Widget _myListView() {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Sun'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('Sun');
          },
        ),
        ListTile(
          title: Text('Moon'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('Moon');
          },
        ),
        ListTile(
          title: Text('Star'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('Star');
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Meeting Room"),
        backgroundColor: Colors.orange[800],
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
                }).toList()
            )
          ],
        ),
      ),
    );
  }
}


