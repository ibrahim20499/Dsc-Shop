import 'package:shop/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Sign.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String Email = "";
  String Password = "";
  bool visability = true;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff6bceff), Color(0xff6bceff)],
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32, right: 32),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        //labelText: "Email",
                        hintText: "Email",
                        //helperText:"Required ",helperStyle:   TextStyle(color: Colors.black87,),
                        prefixIcon: Icon(Icons.email),
                      ),
                      onChanged: (value) {
                        setState(() {
                          Email = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        obscureText: visability,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          //labelText: "Password",
                          hintText: "Password",
                          //helperText:"Required ",helperStyle:   TextStyle(color: Colors.black87,),
                          prefixIcon: Icon(Icons.lock_sharp),
                          suffixIcon: IconButton(
                            icon: Icon(visability
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                visability = !visability;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            Password = value;
                          });
                        },
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Container(
                      //height: 45,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff6bceff),
                              Color(0xFF00abff),
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: ElevatedButton(
                          child: Text('Login'),
                          onPressed: () async {
                            await auth
                                .signInWithEmailAndPassword(
                                    email: Email, password: Password)
                                .then((_) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Dnon't have an account ?"),
                  Text(
                    "Sign Up",
                    style: TextStyle(color: Color(0xff6bceff)),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
