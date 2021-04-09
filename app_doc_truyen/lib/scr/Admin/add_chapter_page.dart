import 'package:app_doc_truyen/scr/blocs/add_chapter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class AddChapter extends StatefulWidget {
  String uid;
  AddChapter(this.uid);
  @override
  _AddChapterState createState() => _AddChapterState();
}

class _AddChapterState extends State<AddChapter> {
  Query query;
  ChapterBloc bloc = new ChapterBloc();
  TextEditingController _nameChapterController = new TextEditingController();
  TextEditingController _storiesController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query=FirebaseDatabase.instance.reference().child("Stories").child(widget.uid).child("Chapter");
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
                StreamBuilder(stream:bloc.authorStream ,
                builder: (context,snapshot)=>TextField(
                  controller: _nameChapterController,
                  decoration: InputDecoration(
                    hintText: "Tên chương",
                    errorText:  snapshot.hasError ? snapshot.error:null,
                  ),
                ),),
                StreamBuilder<Object>(
                  stream: bloc.storiesStream,
                  builder: (context, snapshot) {
                    return Container(
                      height: 200,
                        child: TextField(
                          controller: _storiesController,
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                              errorText:  snapshot.hasError ? snapshot.error:null,
                              labelText: "Viết nội dung truyện ở đây"),
                        )
                    );
                  }
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
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
                  child: FirebaseAnimatedList(  query: query,
                      itemBuilder:(BuildContext context,DataSnapshot snapshot, Animation<double> animation, int index){
                        return InkWell(
                          // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStories2(snapshot.key, snapshot.value["CategoryName"])));},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                margin: EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(38.5),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 33,
                                      color: Color(0xFFD3D3D3).withOpacity(.84),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: snapshot.value["NameChapter"]??"Category ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "asd",
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                      ),
                                      onPressed: (){},
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );}
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onUploadClicked() {
    var isValid = bloc.isValidInfo(_storiesController.text,_nameChapterController.text);
    if(isValid)
    {
      var ref2 = FirebaseDatabase.instance.reference().child("Stories").child(widget.uid);
      var category ={"NameChapter":_nameChapterController.text,"Stories":_storiesController.text};
      ref2.child("Chapter").push().update(category);



      _storiesController.text=" ";
      _nameChapterController.text="";
    }
  }
}
