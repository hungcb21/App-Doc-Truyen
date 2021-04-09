import 'package:app_doc_truyen/scr/Users/details_book_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var uid;
  Query query;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    uid = firebaseAuth.currentUser.uid;
    query = FirebaseDatabase.instance.reference().child("Users").child(uid).child("History");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("History"),),
        body: Container(
          constraints: BoxConstraints.expand(),
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
                              child: Text("Xóa khỏi lịch sử"),
                              isDefaultAction: true,
                              onPressed: () {
                                DatabaseReference refx=FirebaseDatabase.instance.reference();
                                refx.child("Users").child(uid).child("History").child(snapshot.key).remove();
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text("Xóa tất cả khỏi lịch sử"),
                              isDestructiveAction: true,
                              onPressed: () {
                                DatabaseReference refx=FirebaseDatabase.instance.reference();
                                refx.child("Users").child(uid).child("History").remove();
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
                                  SizedBox(
                                    height: 5,
                                  ),
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
    );
  }
}
