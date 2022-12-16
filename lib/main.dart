import 'package:flutter/material.dart';
import 'package:notes/pages/addnotes.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/pages/login.dart';
import 'package:notes/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences sharedPref ;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref=await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:sharedPref.getString("id")==null ? "login":"home",
      routes: {
        "login":(context)=>LoginScreen(),
        "signup":(context)=>SignUpScreen(),
        "home":(context)=>Home(),
        "addnotes":(context)=>Addnotes(),
      },
    );
  }
}
