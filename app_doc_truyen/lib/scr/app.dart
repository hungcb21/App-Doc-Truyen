import 'package:app_doc_truyen/scr/Admin/add_category_page.dart';
import 'package:app_doc_truyen/scr/Admin/add_chapter_page.dart';
import 'package:app_doc_truyen/scr/Admin/add_stories_page.dart';
import 'package:app_doc_truyen/scr/Admin/choose_user_page.dart';
import 'package:app_doc_truyen/scr/Admin/login_admin_page.dart';
import 'package:app_doc_truyen/scr/Admin/menu_page.dart';
import 'package:app_doc_truyen/scr/Users/all_stories_page.dart';
import 'package:app_doc_truyen/scr/Users/chapter_page.dart';
import 'package:app_doc_truyen/scr/Users/home_page.dart';
import 'package:app_doc_truyen/scr/Users/login_page.dart';
import 'package:app_doc_truyen/scr/Users/main_page.dart';
import 'package:app_doc_truyen/scr/Users/user_profile_page.dart';
import 'package:flutter/material.dart';

import 'Users/notification.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
    home: Login(),
    );
  }
}
