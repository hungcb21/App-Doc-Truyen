import 'package:app_doc_truyen/scr/Users/chapter_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';

class DetailsPage extends StatefulWidget {
  final String uid;

  DetailsPage(this.uid);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController commentController = new TextEditingController();
  Query query;
  String name, email, pass, address, phone, avatar;
  Color color;
  bool commentStage = false;
  String ten, image, author, status, uid;
  int like;
  int commenta;
  String commentb;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    uid = auth.currentUser.uid;
    query = FirebaseDatabase.instance
        .reference()
        .child("Stories")
        .child(widget.uid)
        .child("Comment")
        .child("comment");
    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("Stories")
        .child(widget.uid);
    DatabaseReference reference2 = FirebaseDatabase.instance
        .reference()
        .child("Stories")
        .child(widget.uid)
        .child("Like");
    DatabaseReference referenceComment = FirebaseDatabase.instance
        .reference()
        .child("Stories")
        .child(widget.uid)
        .child("Comment");
    DatabaseReference reference3 = FirebaseDatabase.instance
        .reference()
        .child("Stories")
        .child(widget.uid)
        .child("Like")
        .child("Status")
        .child(uid);
    reference3.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        setState(() {
          status = values["Status"];
        });
        print(widget.uid);
      });
    });
    reference2.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        setState(() {
          like = values["Count"];
        });
        print(widget.uid);
      });
    });
    referenceComment.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        setState(() {
          commenta = values["Count"];
          commentb = commenta.toString();
        });
        print(widget.uid);
      });
    });
    reference.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        setState(() {
          ten = values["Name"];
          image = values["Image"];
          author = values["Author"];
        });
        print(widget.uid);
      });
    });
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    DatabaseReference comment =
        FirebaseDatabase.instance.reference().child("Users");
    comment.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        setState(() {
          email = firebaseAuth.currentUser.email;
          name = values["name"];
          phone = values["phone"];
          pass = values["pass"];
          avatar = values["Image"];
        });
        print(image);
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // double c_width = MediaQuery.of(context).size.width*0.8;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          flexibleSpace: Container(
            height: 600,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(image ??
                        "https://scontent.fhan4-1.fna.fbcdn.net/v/t1.0-9/135634832_221471026121571_925480074581197249_o.jpg?_nc_cat=105&ccb=2&_nc_sid=b9115d&_nc_ohc=iZhweHX5XFwAX_qB48d&_nc_ht=scontent.fhan4-1.fna&oh=f4de4a1922e6e0570e7e136cfc62d2db&oe=601B77B2"),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 300,
                    child: Text(
                      ten ?? " ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Text(author ?? " Author name",
                  style: TextStyle(
                    color: Colors.black54,
                  )),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                  Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                  Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                  Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                  Icon(Icons.star, color: Colors.grey, size: 20),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "4.0",
                    style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "(2460)",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1.5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: <Widget>[
                    LikeButton(
                      onTap: onLikeButtonTapped,
                      size: 30,
                      circleColor: CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          // color: color,
                          color: isLiked ? Colors.red : Colors.grey,
                          size: 30,
                        );
                      },
                      likeCount: like ?? 0,
                      countBuilder: (int count, bool isLiked, String text) {
                        var color =
                            isLiked ? Colors.deepPurpleAccent : Colors.grey;
                        Widget result;
                        if (count == 0) {
                          result = Text(
                            "love",
                            style: TextStyle(color: color),
                          );
                        } else
                          result = Text(
                            text,
                            style: TextStyle(color: color),
                          );
                        return result;
                      },
                    ),
                    Text(
                      " Likes",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          commentStage = !commentStage;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.message),
                          Text(
                            commentb ?? "0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(" Comments",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        final action = CupertinoActionSheet(
                          title: Text(
                            "Chia sẻ",
                            style: TextStyle(fontSize: 30),
                          ),
                          message: Text(
                            "Chọn hình thức chia sẻ ",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text("Chia sẻ lên Facebook"),
                              onPressed: () {
                                FlutterShareMe().shareToFacebook(
                                  url:
                                      'https://github.com/hungcb21/Flutter_APP',
                                  msg: ten,
                                );
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                            ),
                            CupertinoActionSheetAction(
                                child: Text("Chia sẻ lên Twitter"),
                                onPressed: () async {
                                  var response = await FlutterShareMe()
                                      .shareToTwitter(
                                          url:
                                              'https://github.com/hungcb21/Flutter_APP',
                                          msg: ten);
                                }),
                            CupertinoActionSheetAction(
                              child: Text("Khác"),
                              // isDestructiveAction: true,
                              onPressed: () async {
                                var response = await FlutterShareMe().shareToSystem(
                                    msg:
                                        'https://github.com/hungcb21/Flutter_APP');
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
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
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          Text("  Share",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 10,
              ),
              !commentStage
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About the book",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Author: $author" ?? "Khong co ",
                          style: TextStyle(color: Colors.grey, height: 1.5),
                        ),
                        Text("Date: ",
                            style: TextStyle(color: Colors.grey, height: 1.5)),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            createButton(
                                icon: Icon(
                                  Icons.book,
                                  color: Colors.white,
                                ),
                                color: Colors.blue,
                                text: "READ NOW"),
                          ],
                        )
                      ],
                    )
                  : Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 250,
                              child: FirebaseAnimatedList(
                                query: query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  return InkWell(
                                    // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryStories(snapshot.key)));},
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 30),
                                          margin: EdgeInsets.only(bottom: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(0, 10),
                                                blurRadius: 33,
                                                color: Color(0xFFD3D3D3)
                                                    .withOpacity(.84),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      snapshot.value["Image"] ??
                                                          "https://scontent.fhan4-1.fna.fbcdn.net/v/t1.0-9/135634832_221471026121571_925480074581197249_o.jpg?_nc_cat=105&ccb=2&_nc_sid=b9115d&_nc_ohc=iZhweHX5XFwAX_qB48d&_nc_ht=scontent.fhan4-1.fna&oh=f4de4a1922e6e0570e7e136cfc62d2db&oe=601B77B2")),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 0, 0),
                                                child: Container(
                                                  width: 200,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      new Text(
                                                        snapshot.value[
                                                                "Comment"] ??
                                                            "",
                                                        overflow:
                                                            TextOverflow.fade,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: TextField(
                                    controller: commentController,
                                    decoration:
                                        InputDecoration(hintText: "Comment"),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: onCommentClick,
                                  color: Colors.blue,
                                  child: Text("Send"),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createButton({icon, color, text}) {
    return ButtonTheme(
      minWidth: 200,
      height: 45,
      child: FlatButton.icon(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Chappter(widget.uid)));
        },
        icon: icon,
        label: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();
    if (!isLiked) {
      like = like + 1;
      var ref = FirebaseDatabase.instance
          .reference()
          .child("Stories")
          .child(widget.uid);
      var ref2 = FirebaseDatabase.instance
          .reference()
          .child("Stories")
          .child(widget.uid)
          .child("Like")
          .child("Status");
      var status = {"Status": "Like"};
      var story = {"Name": ten, "Image": image, "Author": author};
      var ref3 =
          FirebaseDatabase.instance.reference().child("Users").child(uid);
      ref3.child("Favorite").child(ten).update(story);
      ref2.child(uid).update(status);
      var likes = {"Count": like};
      ref.child("Like").update(likes);
    } else if (isLiked) {
      like = like - 1;
      var ref = FirebaseDatabase.instance
          .reference()
          .child("Stories")
          .child(widget.uid);
      var ref2 = FirebaseDatabase.instance
          .reference()
          .child("Stories")
          .child(widget.uid)
          .child("Like")
          .child("Status");
      var ref3 =
          FirebaseDatabase.instance.reference().child("Users").child(uid);
      var likes = {"Count": like};
      ref3.child("Favorite").child(ten).remove();
      ref.child("Like").update(likes);
    }

    return !isLiked;
  }

  void onCommentClick() {
    if (commentController.text == "") {
      Fluttertoast.showToast(msg: "Vui lòng nhập bình luận");
    } else {
      commenta = commenta + 1;
      var ref2 = FirebaseDatabase.instance
          .reference()
          .child("Stories")
          .child(widget.uid);
      var count = {"Count": commenta};
      var ref3 = FirebaseDatabase.instance
          .reference()
          .child("Stories")
          .child(widget.uid);
      var category = {
        "Image": avatar,
        "Comment": commentController.text,
        "Name": name
      };
      ref2.child("Comment").child("comment").push().update(category);
      ref3.child("Comment").update(count);
      setState(() {
        commentb = commenta.toString();
      });
      commentController.text = "";
    }
  }
}
