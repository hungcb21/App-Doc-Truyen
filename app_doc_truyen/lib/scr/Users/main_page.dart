import 'package:app_doc_truyen/model/Comic.dart';
import 'package:app_doc_truyen/scr/Users/all_stories_page.dart';
import 'package:app_doc_truyen/scr/Users/details_book_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gradient_text/gradient_text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = new TextEditingController();
  Query query = FirebaseDatabase.instance.reference().child('Stories');
  bool searchState = false;
  List<Comic> listComicFromDatabase = new List<Comic>();
  List<Comic> datalist = [];
  String image;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var uid = firebaseAuth.currentUser.uid;
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("Users");
    reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        setState(() {
          image = values["Image"];
        });
        print(image);
      });
    });
    // DatabaseReference refStories= FirebaseDatabase.instance.reference().child("Stories");
    // refStories.once().then((DataSnapshot dataSnapshot){
    //   datalist.clear();
    //   var keys= dataSnapshot.value.keys;
    //   var values = dataSnapshot.value;
    //   for(var key in keys)
    //   {
    //     Comic data = new Comic(
    //         values[key]["Author"],
    //         values[key]["Name"],
    //         values[key]["Image"],
    //     );
    //     datalist.add(data);
    //     listComicFromDatabase=datalist;
    //   }
    // });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: true,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(offset: Offset(3, 3), blurRadius: 10),
                              ]),
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(image ??
                                  "https://scontent.fsgn2-1.fna.fbcdn.net/v/t1.0-9/50396385_2259091907660313_3015233235551518720_n.jpg?_nc_cat=107&ccb=3&_nc_sid=09cbfe&_nc_ohc=yduOi5LTFQ0AX8p4ctU&_nc_oc=AQmn2Vt--a-rHU_emh68yd1LjGrWkXuRcF0cyv2MGFWEFRGGiDfo4Twl6wQ31KKySfi8YRM90YTCDGIrYwOb1fRC&_nc_ht=scontent.fsgn2-1.fna&oh=c7fb50348a6fe23eed4b779c84345eb5&oe=6067A9F9")),
                        ),
                        Container(
                            width: 200,
                            child: !searchState
                                ? Center(
                                    child: GradientText(
                                      "BOOKS",
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue,
                                          Colors.orange,
                                          Colors.pink
                                        ],
                                      ),
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : TypeAheadField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                            autofocus: true,
                                            style: DefaultTextStyle.of(context)
                                                .style
                                                .copyWith(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                    suggestionsCallback: (searchString) async {
                                      return await searchComic(searchString);
                                    },
                                    itemBuilder: (context, comic) {
                                      return ListTile(
                                          // leading: Netw.network(comic.image),
                                          title: Text("${comic.name}"),
                                          subtitle: Text("${comic.author}"));
                                    },
                                    onSuggestionSelected: (comic) {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsPage(comic.key)));
                                        searchState = !searchState;
                                      });
                                    })
                            // : TextFormField(
                            //     controller: _searchController,
                            //     decoration: InputDecoration(
                            //       icon: Icon(Icons.search),
                            //       hintText: "Search...",
                            //       hintStyle: TextStyle(color: Colors.white),
                            //     ),
                            //   ),
                            ),
                        !searchState
                            ? IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 25,
                                ),
                                onPressed: () {
                                  setState(() {
                                    searchState = !searchState;
                                  });
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    searchState = !searchState;
                                  });
                                },
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      reverse: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 10),
                      children: <Widget>[
                        makeItem(image: "images/pic1.jpg"),
                        makeItem(image: "images/pic2.jpg"),
                        makeItem(image: "images/pic3.jpg"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Popular",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              OutlineButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                borderSide: BorderSide(
                                    width: 3, color: Colors.blue.shade300),
                                child: Text(
                                  "View All",
                                  style: TextStyle(color: Colors.blue.shade300),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllStories()));
                                },
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: new FirebaseAnimatedList(
                            query: query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              // List<Comic> comic = new List<Comic>();
                              Comic data = new Comic(
                                snapshot.key,
                                snapshot.value["Author"],
                                snapshot.value["Name"],
                                snapshot.value["Image"],
                              );
                              datalist.add(data);
                              listComicFromDatabase = datalist;
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsPage(snapshot.key)));
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
                                                  image: new NetworkImage(snapshot
                                                          .value["Image"] ??
                                                      "https://znews-photo.zadn.vn/w660/Uploaded/ofh_btgazspf/2020_04_21/72425168_2190164277756889_5548989457421565952_o.jpg"),
                                                  fit: BoxFit.cover),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(5, 5),
                                                    blurRadius: 10),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              snapshot.value["Name"] ?? "",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot.value["Author"] ??
                                                  "Author name",
                                              style: TextStyle(
                                                  color: Colors.black45),
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
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Comic>> searchComic(String searchString) async {
    return listComicFromDatabase
        .where((comic) =>
            comic.name.toLowerCase().contains(searchString.toLowerCase()))
        .toList();
  }
}

Widget makeItem({image}) {
  return Container(
    width: 330,
    margin: EdgeInsets.only(right: 20, bottom: 40),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      boxShadow: [
        BoxShadow(offset: Offset(5, 5), blurRadius: 10),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 30, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[],
      ),
    ),
  );
}
