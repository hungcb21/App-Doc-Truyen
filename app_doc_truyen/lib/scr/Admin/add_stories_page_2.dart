import 'dart:io';

import 'package:app_doc_truyen/scr/blocs/add_stories_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'add_chapter_page.dart';
class AddStories2 extends StatefulWidget {
  String cateuid,category;
  AddStories2(this.cateuid,this.category);
  @override
  _AddStories2State createState() => _AddStories2State();
}

class _AddStories2State extends State<AddStories2> {
  Query query;
  TextEditingController storiesController = new TextEditingController();
  TextEditingController authorController = new TextEditingController();
  String imageUrl,image;
  StoriesBloc bloc = new StoriesBloc();
  DatabaseReference ref = FirebaseDatabase.instance.reference().child("Stories");
  DatabaseReference ref2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query= FirebaseDatabase.instance.reference().child('Category').child(widget.cateuid).child("Stories");
    ref2 = FirebaseDatabase.instance.reference().child("Category").child(widget.cateuid).child("Stories");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                  stream: bloc.storiesStream,
                  builder: (context,snapshot)=>TextField(
                    controller: storiesController,
                    decoration: InputDecoration(
                      hintText: "Tên truyện",
                      errorText:  snapshot.hasError ? snapshot.error:null,
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: bloc.authorStream,
                  builder: (context,snapshot)=>TextField(
                    controller: authorController,
                    decoration: InputDecoration(
                      hintText: "Tên tác giả",
                      errorText:  snapshot.hasError ? snapshot.error:null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (imageUrl != null)?NetworkImage(imageUrl):NetworkImage("https://znews-photo.zadn.vn/w660/Uploaded/ofh_btgazspf/2020_04_21/72425168_2190164277756889_5548989457421565952_o.jpg")
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  height: 40,
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                    onPressed: ()=>uploadImage(),
                    child: Text("Upload image",style: TextStyle(color: Colors.white),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: SizedBox(
                    width: 140,
                    height: 40,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                      onPressed: _onUploadClicked,
                      child: Text("Upload",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  child: new FirebaseAnimatedList(
                    shrinkWrap: true,
                    reverse: true,
                    query: query,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot , Animation<double> animation,int index){
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddChapter(snapshot.key)));
                        },
                        child: Container(
                          height: 100,
                          width: 400,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Hero(
                                tag: snapshot.value["Name"],
                                child: Container(
                                  height: 100,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: new NetworkImage(snapshot.value["Image"]
                                              ??"https://znews-photo.zadn.vn/w660/Uploaded/ofh_btgazspf/2020_04_21/72425168_2190164277756889_5548989457421565952_o.jpg"), fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(offset: Offset(5, 5), blurRadius: 10),
                                      ]),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.value["Name"]??"",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapshot.value["Author"]?? "Author name",
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    AlertDialog alert = AlertDialog(
                                      title: Text("Xóa truyện"),
                                      content: Text("Bạn có muốn xóa truyện ?"),
                                      actions: <Widget>[
                                        FlatButton(
                                            child: Text("Không"),
                                            onPressed: (){Navigator.of(context, rootNavigator: true).pop();}
                                        ),
                                        FlatButton(
                                          child: Text("Có"),
                                          onPressed:  () {
                                            ref.child(snapshot.key).remove();
                                            ref2.child(snapshot.key).remove();
                                            Navigator.of(context, rootNavigator: true).pop();},
                                        ),
                                      ],
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  uploadImage() async{
    final _storage = FirebaseStorage.instance;
    PickedFile image;
    final _picker =ImagePicker();
    image= await _picker.getImage(source: ImageSource.gallery);
    var file = File(image.path);
    if(image != null)
    {
      var snapshot =await _storage.ref().child(storiesController.text).putFile(file);
      var dowloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl= dowloadUrl;
      });
    }
    else
    {
      print("Chua co anh");
    }
  }

  void _onUploadClicked() {
    var isValid = bloc.isValidInfo(storiesController.text,authorController.text);
        if(isValid)
          {
            var ref = FirebaseDatabase.instance.reference().child("Category").child(widget.cateuid).child("Stories");
            var ref2 = FirebaseDatabase.instance.reference().child("Stories");
            var ref3 = FirebaseDatabase.instance.reference().child("Stories");
            var ref4 = FirebaseDatabase.instance.reference().child("Stories");
            var refSearch = FirebaseDatabase.instance.reference().child("Search");
            var like ={"Count":0};
            var comment={"Count":0};
            var category ={"Name":storiesController.text,"Image":imageUrl,"Category":widget.category,"Author":authorController.text};
            ref.child(storiesController.text).set(category);
            ref2.child(storiesController.text).set(category);
            ref4.child(storiesController.text).child("Comment").set(comment);
            ref3.child(storiesController.text).child("Like").set(like);
            Map<String,String> demo={
              "Name":storiesController.text,
              "Image":imageUrl,
              "Category":widget.category,
              "Author":authorController.text
            };
            refSearch.child(storiesController.text).push().set(demo);

            storiesController.text="";
            authorController.text="";
          }
  }
}


