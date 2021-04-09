import 'package:app_doc_truyen/scr/Admin/add_stories_page_2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class AddStories extends StatefulWidget {
  @override
  _AddStoriesState createState() => _AddStoriesState();
}
class _AddStoriesState extends State<AddStories> {
  Query query;
  void initState() {
    // TODO: implement initState
    super.initState();
    query= FirebaseDatabase.instance.reference().child("Category");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              height: 400,
              child:FirebaseAnimatedList(  query: query,
                  itemBuilder:(BuildContext context,DataSnapshot snapshot, Animation<double> animation, int index){
                    return InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStories2(snapshot.key, snapshot.value["CategoryName"])));},
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
                                        text: snapshot.value["CategoryName"]??"Category ",
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
    ),
    ),
      ),
    );
  }
}
