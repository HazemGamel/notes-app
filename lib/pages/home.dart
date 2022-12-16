import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/component/cardnotes.dart';
import 'package:notes/component/constans.dart';
import 'package:notes/data/crud.dart';
import 'package:notes/main.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:notes/pages/editnotes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with dataserver {

  getnotes()async{
    var response =await postRequest(LinkViewNotes, {
      "id":sharedPref.getString("id")
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(onPressed: (){
            sharedPref.clear();
            Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
          }, icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Container(
        //height: 300,
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
             FutureBuilder(
               future: getnotes(),
                 builder: (BuildContext context,AsyncSnapshot snapshot){
                 if(snapshot.hasData ) {
                   if(snapshot.data['status']=="failed")
                     return Center(child: Text("لا يوجد ملاحظات "));
                   return ListView.builder(
                     shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemCount: snapshot.data['data'].length,
                       itemBuilder: (context,index){
                         return CardNotes(
                             ondelete: ()async{
                             var response =await postRequest(LinkdeleteNotes,{
                               "id":snapshot.data['data'][index]['notes_id'].toString(),
                               "imagename":snapshot.data['data'][index]['notes_image']
                             });
                             if(response['status']=="success"){
                               Navigator.of(context).pushReplacementNamed("home");
                             }
                             },
                             ontab: (){
                           Navigator.of(context).push(MaterialPageRoute(builder:
                               (_)=>editnotes(notes:snapshot.data['data'][index] ,)));
                         },
                             notesModel: NotesModel.fromJson(snapshot.data['data'][index]),
                            );
                       },
                     );
                 }
                 if(snapshot.connectionState==ConnectionState.waiting){
                   return Text("waiting");
                 }
                 return Text("loading");
             })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){
        Navigator.of(context).pushNamed("addnotes");
      },child: Icon(Icons.add),),
    );
  }
}
