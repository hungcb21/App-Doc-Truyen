import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'details_book_page.dart';
class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Query query;
  var uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    uid = auth.currentUser.uid;
    query= FirebaseDatabase.instance.reference().child("Users").child(uid).child("Favorite");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Yêu thích"),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Container(
              height: 900,
              child: FirebaseAnimatedList(
                query: query,
                itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index)
                {
                  return InkWell(
                    onLongPress: (){
                      final action = CupertinoActionSheet(
                        // title: Text(
                        //   "Proto Coders Point", style: TextStyle(fontSize: 30),
                        // ),
                        // message: Text(
                        //   "Select any action ",
                        //   style: TextStyle(fontSize: 15.0),
                        // ),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: Text("Xóa khỏi yêu thích"),
                            isDefaultAction: true,
                            onPressed: () {
                              DatabaseReference refx=FirebaseDatabase.instance.reference();
                              refx.child("Users").child(uid).child("Favorite").child(snapshot.key).remove();
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Text("Xóa tất cả"),
                            isDestructiveAction: true,
                            onPressed: () {
                              DatabaseReference refx=FirebaseDatabase.instance.reference();
                              refx.child("Users").child(uid).child("Favorite").remove();
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                      );
                      showCupertinoModalPopup(
                          context: context, builder: (context) => action);
                    },
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
                                      image: new NetworkImage(snapshot.value["Image"]), fit: BoxFit.cover),
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
                                // Row(
                                //   children: <Widget>[
                                //     Icon(
                                //       Icons.star,
                                //       color: Colors.orange.shade700,
                                //       size: 20,
                                //     ),
                                //     SizedBox(
                                //       width: 5,
                                //     ),
                                //     Text(
                                //       "4.0",
                                //       style: TextStyle(
                                //           color: Colors.orange.shade700,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 15),
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
