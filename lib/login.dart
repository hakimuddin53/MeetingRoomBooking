import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/material.dart';

import 'base_page_state.dart';
import 'components/custom_snackbar.dart';
import 'data/auth_repo.dart';
import 'data/result.dart';
import 'home.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends BasePageState<LoginDemo> {
  final _formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;

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
                      child: Image.asset('assets/images/abxexpress.png')),
                ),
              ),
              Form(
                key: _formKey,
                child: new Column(
                  children: <Widget>[
                    new TextFormField(
                      decoration: InputDecoration(
                          hintText: "Username", labelText: "Username"),
                      // keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.length == 0)
                          return "Please enter username";
                        else
                          return null;
                      },
                      onSaved: (val) => _email = val!,
                    ),
                    new TextFormField(
                      decoration: InputDecoration(
                          hintText: "Password", labelText: "Password"),
                      obscureText: true,
                      validator: (val) {
                        if (val!.length == 0)
                          return "Please enter password";
                        else
                          return null;
                      },
                      onSaved: (val) => _password = val!,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          // test();
                          _signInHandling();

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => MyHome()));
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

  void _signInHandling() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showLoadingView(true);
      FocusScope.of(context).requestFocus(FocusNode());

      Result result = await AuthRepo().login(_email, _password);
      if (result.isSuccess) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MyHome()));
      } else {
        CustomSnackbar().show(context, "Login Failed!!", MessageType.ERROR);
      }
      showLoadingView(false);
    }
  }
}
