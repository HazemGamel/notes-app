import 'package:flutter/material.dart';
import 'package:notes/component/constans.dart';
import 'package:notes/component/coustemTextForm.dart';
import 'package:notes/data/crud.dart';
import 'package:notes/main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  final formkey =GlobalKey<FormState>();
  dataserver _auth = dataserver();

  login()async{
     if(formkey.currentState!.validate()){
       var response =await _auth.postRequest(loginLink, {
         "email":email.text,
         "password":password.text,
       });
       if(response['status'] == "success"){
         sharedPref.setString("id", response['data']['id'].toString());
       Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
       }else{
         print("sin in failed");
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
                  await login();
                },
                child: Text("login"),),
              TextButton(onPressed: (){
                Navigator.of(context).pushNamed("signup");
              }, child: Text("Sing up =>")),
            ],
          ),
        ),
      ),
    );
  }
}
