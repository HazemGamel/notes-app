import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
class dataserver{

  getRequest(String url)async{
    try{
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var responsebody =jsonDecode(response.body);
        return responsebody;
      }else{
        print("error ${response.statusCode}");
      }
    }catch(e){
      print("error catch $e");
    }
  }

  postRequest(String url, Map data)async{
    try{
      http.Response response = await http.post(Uri.parse(url),body: data);
      if(response.statusCode == 200){
        var responsebody =jsonDecode(response.body);
        print(responsebody);
        return responsebody;
      }else{
        print("error ${response.statusCode}");
      }
    }catch(e){
      print("error catch $e");
    }
  }


  postRequestWithFile(String url, Map data,File file)async{
    var request =  http.MultipartRequest("post",Uri.parse(url));
     var lenght = await file.length();
     var stream = http.ByteStream(file.openRead());

    var myrequestfile = http.MultipartFile("file",stream,lenght,
        filename: basename(file.path));
    request.files.add(myrequestfile);
    data.forEach((key, value) {
      request.fields[key]=value;
    });
   var myrequst=await request.send();

   var response =await http.Response.fromStream(myrequst);

   if(myrequst.statusCode==200){
     return jsonDecode(response.body);
   }else{
   print("error ${myrequst.statusCode}");
   }

  }
}