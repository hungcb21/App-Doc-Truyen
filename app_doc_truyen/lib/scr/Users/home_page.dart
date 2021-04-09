import 'package:app_doc_truyen/scr/Users/all_stories_page.dart';
import 'package:app_doc_truyen/scr/Users/category_page.dart';
import 'package:app_doc_truyen/scr/Users/details_book_page.dart';
import 'package:app_doc_truyen/scr/Users/favorite_page.dart';
import 'package:app_doc_truyen/scr/Users/history_page.dart';
import 'package:app_doc_truyen/scr/Users/main_page.dart';
import 'package:app_doc_truyen/scr/Users/user_profile_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _childrenf = [
    Home(),
    CategoryPage(),
    Favorite(),
    History(),
    UserProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(child: _childrenf[_currentIndex]),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                primaryColor: Colors.black,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: TextStyle(color: Colors.black))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              // selectedItemColor: Colors.blue,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    label: "Home",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.waves_outlined, color: Colors.black),
                    label: "Thể loại",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite, color: Colors.black),
                    label: "Yêu thích",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.history,
                      color: Colors.black,
                    ),
                    label: "Lịch sử",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    label: "Cá nhân",
                    backgroundColor: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
