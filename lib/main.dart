import 'package:flutter/material.dart';
import 'package:login_ui/services/home.dart';
import 'package:login_ui/services/login.dart';
import 'package:login_ui/services/secondScreen.dart';
import 'package:login_ui/services/signup.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //initialRoute:'/signup',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: GoogleFonts.lato().fontFamily,
          appBarTheme: AppBarTheme(
            //color:Colors.white,
            elevation:0,
            //iconTheme: IconThemeData(color : Colors.black),
            //textTheme: Theme.of(context).textTheme,
          ),
        ),
        routes: {
          '/': (context) => Login(),
          '/signup': (context) => SignUp(),
          '/home' : (context) => Home(),
          '/gridView' : (context)=>SecondScreen()
        });
  }
}
