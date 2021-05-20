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

  // Initially password is obscure
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.orange[800],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 70.0),
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            // decoration: InputDecoration(
                            //     hintText: "Username", labelText: "Username"),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Username',
                            ),
                            // keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val!.length == 0)
                                return "Please enter username";
                              else
                                return null;
                            },
                            onSaved: (val) => _email = val!,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20.0),
                          child: TextFormField(
                            // decoration: InputDecoration(
                            //     hintText: "Password", labelText: "Password"),

                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText:
                                !_passwordVisible, //This will obscure text dynamically
                            validator: (val) {
                              if (val!.length == 0)
                                return "Please enter password";
                              else
                                return null;
                            },
                            onSaved: (val) => _password = val!,
                          ),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
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
          super.loadingWidget
        ],
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
        // Navigator.push(context, MaterialPageRoute(builder: (_) => MyHome()));

        // Navigator.of(context).push(
        //     MaterialPageRoute(
        //         settings: RouteSettings(name: "/MyHome"),
        //         builder: (context) => MyHome(),

        Navigator.of(context).push(
          MaterialPageRoute(
            settings: RouteSettings(name: "/MyHome"),
            builder: (context) => MyHome(),
          ),
        );
      } else {
        CustomSnackbar().show(context, "Login Failed!!", MessageType.ERROR);
      }
      showLoadingView(false);
    }
  }
}
