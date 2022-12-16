import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/component/constans.dart';
import 'package:notes/component/coustemTextForm.dart';
import 'package:notes/data/crud.dart';
import 'package:notes/main.dart';

class Addnotes extends StatefulWidget {
  @override
  _AddnotesState createState() => _AddnotesState();
}

class _AddnotesState extends State<Addnotes> with dataserver {
  TextEditingController title =TextEditingController();
  TextEditingController content =TextEditingController();
  File? myfile;
  final formkey =GlobalKey<FormState>();
  bool isloading =false;
  addnotes()async{
    if(formkey.currentState!.validate()){
      isloading=true;
      setState(() {

      });
      var response =await postRequestWithFile(LinkaddNotes, {
        "title":title.text,
        "content":content.text,
        "id":sharedPref.getString("id"),
      },myfile!);
      isloading=false;
      setState(() {

      });
      if(response['status']=="success"){
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      }else{
        print("error add notes");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              CostumTextForm(hint: 'title', mycontroller: title,
              val: (val){
                if(val!.isEmpty){
                  return "please enter your title";
                }
                return null;
              },),
              CostumTextForm(hint: 'content', mycontroller: content,
              val: (val){
                if(val!.isEmpty){
                  return "please enter your content";
                }
                return null;
              },),
              SizedBox(height: 20,),
              MaterialButton(onPressed: ()async{
                showModalBottomSheet(context: context,
                    builder: (context)=>Container(
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("chose the photo"),
                            SizedBox(height: 20,),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: ()async{
                                  XFile? xfile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  myfile=File(xfile!.path);
                                  Navigator.of(context).pop();
                                  setState(() {
                                  });
                                },
                                child: Text("Gallary",style: TextStyle(fontSize: 20),),
                              ),
                            ),
                            SizedBox(height: 20,),
                            InkWell(
                              onTap: ()async{
                                XFile? xfile = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);
                                myfile=File(xfile!.path);
                                Navigator.of(context).pop();
                                setState(() {
                                });
                              },
                              child: Text("camera",style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
                child: Text("chose photo"),
                color:myfile==null? Colors.blue:Colors.green,
                textColor: Colors.white,),
              SizedBox(height: 20,),
              isloading == true?Center(
                child: CircularProgressIndicator(),
              ):
              MaterialButton(onPressed: ()async{
                await addnotes();
              },
                child: Text("Add"),
                color: Colors.blue,
                textColor: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}
