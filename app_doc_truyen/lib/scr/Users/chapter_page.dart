import 'package:app_doc_truyen/scr/Users/read_comic_page.dart';
import 'package:app_doc_truyen/scr/Users/rounded_button.dart';
import 'package:app_doc_truyen/scr/fire_base/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class Chappter extends StatefulWidget {
  String uid;
  Chappter(this.uid);
  @override
  _ChappterState createState() => _ChappterState();
}

class _ChappterState extends State<Chappter> {
  Query query;
  String ten,image,author;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query = FirebaseDatabase.instance.reference().child('Stories').child(widget.uid).child('Chapter');
    DatabaseReference reference = FirebaseDatabase.instance.reference().child("Stories").child(widget.uid);
    reference.once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values = snapshot.value;
      values.forEach((key, value) {
        setState(() {
          ten= values["Name"];
          image = values["Image"];
          author= values["Author"];
        });
        print(widget.uid);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: size.height * .12, left: size.width * .1, right: size.width * .02),
                    height: size.height * .48,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image??"https://scontent.fhan4-1.fna.fbcdn.net/v/t1.0-9/135634832_221471026121571_925480074581197249_o.jpg?_nc_cat=105&ccb=2&_nc_sid=b9115d&_nc_ohc=iZhweHX5XFwAX_qB48d&_nc_ht=scontent.fhan4-1.fna&oh=f4de4a1922e6e0570e7e136cfc62d2db&oe=601B77B2"),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 0),
                      child: Text(
                        ten ??"Influence",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: size.height * .48 - 20),
                  child: Container(
                    height: 300,
                      child: FirebaseAnimatedList(query: query, itemBuilder:(BuildContext context, DataSnapshot snapshot , Animation<double> animation,int index){
                        return InkWell(
                          onTap: (){
                            _onChapterClick();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadComic(snapshot.value["Stories"],snapshot.value["NameChapter"])));},
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                  margin: EdgeInsets.only(bottom: 16),
                                  width: size.width - 48,
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
                                              text: snapshot.value["NameChapter"]??"Chapter ",
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
                        );
                      }),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
  _onChapterClick()
  {
    FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
    String UID = _fireBaseAuth.currentUser.uid;
    var stories ={"Image":image,"uid":widget.uid,"Name":ten};
    var ref = FirebaseDatabase.instance.reference().child("Users").child(UID).child("History");
    ref.child(widget.uid).set(stories);
  }
}

