

import 'package:app_doc_truyen/scr/Users/chapter_page.dart';

class Comic{
  String key,author,name,picture;


  Comic(this.key,this.author, this.name, this.picture);

  Comic.fromJson(Map<String,dynamic> json)
  {
    author = json["Author"];
    picture = json["Picture"];
    name = json["Name"];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data["Author"]=this.author;
    data["Name"]= this.name;
    data["Picture"]= this.picture;
  }
}