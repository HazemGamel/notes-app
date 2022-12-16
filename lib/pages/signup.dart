import 'package:flutter/material.dart';
import 'package:notes/component/constans.dart';
import 'package:notes/component/coustemTextForm.dart';
import 'package:notes/data/crud.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController username =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  final formkey =GlobalKey<FormState>();
  dataserver _auth = dataserver();

  singup()async{
  if(formkey.currentState!.validate()){
   var response= await _auth.postRequest(singupLink, {
      "username":username.text,
      "email":email.text,
      "password":password.text
       });
   if(response['status'] == "success"){
    Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
   }else{
     print("sinup failed");
   }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 150),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CostumTextForm(
                val: (val){
                  if(val!.isEmpty){
                    return "Please enter your name";
                  }
                },
                mycontroller: username,hint: "username",
              ),
              CostumTextForm(
                val: (val){
                  if(val!.isEmpty){
                    return "Please enter your email";
                  }
                },
                mycontroller: email,
                hint: "email",
              ),
              CostumTextForm(
                val: (val){
                  if(val!.isEmpty){
                    return "Please enter your password";
                  }
                },
                mycontroller: password,
                hint: "password",
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: ()async{
                 await singup();
                },
              child: Text("SinUp"),),
              TextButton(onPressed: (){
                Navigator.of(context).pushNamed("login");
              }, child: Text("Sing in =>")),
            ],
          ),
        ),
      ),
    );
  }
}
