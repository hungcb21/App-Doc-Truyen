import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'details_book_page.dart';
class CategoryStories extends StatefulWidget {
  String uid;
  CategoryStories(this.uid);
  @override
  _CategoryStoriesState createState() => _CategoryStoriesState();
}

class _CategoryStoriesState extends State<CategoryStories> {
  Query query;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query = FirebaseDatabase.instance.reference().child('Category').child(widget.uid).child("Stories");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),

            child: FirebaseAnimatedList(
              query: query,
              itemBuilder: (BuildContext context, DataSnapshot snapshot , Animation<double> animation,int index){
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(snapshot.key)));
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
                                    image: new NetworkImage(snapshot.value["Image"]??"https://scontent.fhan4-1.fna.fbcdn.net/v/t1.0-9/135634832_221471026121571_925480074581197249_o.jpg?_nc_cat=105&ccb=2&_nc_sid=b9115d&_nc_ohc=iZhweHX5XFwAX_qB48d&_nc_ht=scontent.fhan4-1.fna&oh=f4de4a1922e6e0570e7e136cfc62d2db&oe=601B77B2"), fit: BoxFit.cover),
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
                                snapshot.value["Author"]??"Author name",
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
                            icon: Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },),
          ),
        ),
    );
  }
}
