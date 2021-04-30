import 'package:abx_booking/pages/basics_example.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.orange[800],
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/flutter-logo.png')),
              ),
            ),


            Form(key: _formKey,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    decoration: InputDecoration(
                        hintText: "aa@bb.com",
                        labelText: "Email"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val){
                      if (val.length == 0)
                        return "Please enter email";
                      else if (!val.contains("@"))
                        return "Please enter valid email";
                      else
                        return null;
                    },
                    onSaved: (val)=>_email=val,
                  ),
                  new TextFormField(
                    decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password"
                    ),
                    obscureText: true,
                    validator: (val){
                      if (val.length == 0)
                        return "Please enter password";
                      else if (val.length <= 5)
                        return "Your password should be more then 6 char long";
                      else
                        return null;
                    },
                    onSaved: (val)=>_password=val,
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // _scaffoldKey.currentState.showSnackBar(new SnackBar(
                          //   content: new Text("Your email: $_email and Password: $_password"),
                          // ));

                          Navigator.push(context, MaterialPageRoute(builder: (_) => MyHome()));
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 130,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
