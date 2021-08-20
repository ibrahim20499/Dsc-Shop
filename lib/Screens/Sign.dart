import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class SignupPage extends StatefulWidget {
    @override
    _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
    String Email="";
    String Password="";
    bool visability=true;

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
                            height: MediaQuery.of(context).size.height/3.5,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                        Color(0xff6bceff),
                                        Color(0xff6bceff)
                                    ],
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(90)
                                )
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Spacer(),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Icon(Icons.person,
                                            size: 90,
                                            color: Colors.white,
                                        ),
                                    ),
                                    Spacer(),

                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 32,
                                                right: 32
                                            ),
                                            child: Text('Sign Up',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18
                                                ),
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ),

                        Container(
                            height: MediaQuery.of(context).size.height/2,
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
                                                prefixIcon: Icon(Icons.email),
                                            ),
                                            onChanged: (value){
                                                setState(() {
                                                    Email=value;
                                                });
                                            },
                                        ),
                                    ),
                                    SizedBox(
                                        height: 5,),
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
                                                prefixIcon: Icon(Icons.lock_sharp),
                                                suffixIcon: IconButton(
                                                    icon: Icon(visability?Icons.visibility_off:Icons.visibility),
                                                    onPressed: (){
                                                        setState(() {
                                                            visability =!visability;
                                                        });
                                                    },
                                                ),
                                            ),
                                            onChanged: (value){
                                                setState(() {
                                                    Password=value;
                                                });
                                            },
                                        )
                                    ),
                                    SizedBox(
                                        height: 15,
                                    ),
                                    ElevatedButton(
                                        child: Text("Sign Up",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ),),
                                        onPressed: () async{
                                            await auth.createUserWithEmailAndPassword(email: Email, password: Password).then((_) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => MyHomePage(
                                                        )));
                                            });
                                        },
                                    ),
                                ],
                            ),
                        ),

                        InkWell(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Text("Have an account ?"),
                                    Text("Login",style: TextStyle(color: Color(0xff6bceff)),),
                                ],
                            ),
                            onTap: (){
                                Navigator.pop(context);
                            },
                        ),
                    ],

                ),
            ),
        );
    }
}