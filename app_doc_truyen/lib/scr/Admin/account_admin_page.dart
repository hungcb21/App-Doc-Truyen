import 'package:app_doc_truyen/scr/Admin/choose_user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class AccountAdmin extends StatefulWidget {
  @override
  _AccountAdminState createState() => _AccountAdminState();
}

class _AccountAdminState extends State<AccountAdmin> {
  TextEditingController _userController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  String imageUrl;
  bool _validate = true;
  String name,email,pass,address,phone,image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var uid = firebaseAuth.currentUser.uid;
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Users");
    reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values= snapshot.value;
      values.forEach((key, values) {
        setState(() {
          email= firebaseAuth.currentUser.email;
          name = values["name"];
          phone = values["phone"];
          pass = values["pass"];
          image = values["Image"];
        });
        print(image);
      });}
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:AppBar(
          leading: InkWell(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Column(
                children: [
                  Column(
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
                                    text: email??"Email ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
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
                                    text: name??"Name ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.update,
                                size: 18,
                              ),
                              onPressed: _updateName,
                            )
                          ],
                        ),
                      ),

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
                                    text: '${pass.replaceAll(RegExp("."), "*")}'??"Password",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.update,
                                size: 18,
                              ),
                              onPressed: _showDialog,
                            )
                          ],
                        ),
                      ),
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
                                    text: phone??"Phone ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.update,
                                size: 18,
                              ),
                              onPressed: _updatePhone,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: Center(
                          child: SizedBox(
                            width: 140,
                            height: 40,
                            child: RaisedButton(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15))),
                              onPressed: _signOut,
                              child: Text("Log out",
                                style: TextStyle(color: Colors.white,fontSize: 20),),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _signOut() {
    AlertDialog alert = AlertDialog(
      title: Text("Đăng xuất"),
      content: Text("Bạn có muốn đăng xuất ?"),
      actions: <Widget>[
        FlatButton(
            child: Text("Không"),
            onPressed: (){Navigator.of(context, rootNavigator: true).pop();}
        ),
        FlatButton(
            child: Text("Có"),
            onPressed:  () {
              FirebaseAuth.instance.signOut();
              runApp(
                  new MaterialApp(
                    home: new ChooseUser(),
                  )
              );
            }
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }
  _showDialog() async {
    await showDialog<String>(
      builder: (context) => new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: TextField(
                controller: _userController,
                decoration: new InputDecoration(
                    errorText: _validate ? "Không hợp lệ" : null,
                    labelText: "Chỉnh sửa thông tin"),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Thoát'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              }),
          new FlatButton(
              child: const Text('Xác nhận'),
              onPressed: () {
                if(_userController.text.length<6)
                {
                  _validate =true;
                }
                else{
                  _validate=false;
                  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                  User user = firebaseAuth.currentUser;
                  var uid = user.uid;
                  DatabaseReference databaseReference= FirebaseDatabase.instance.reference().child("Users");
                  databaseReference.child(uid).update({
                    'pass': _userController.text
                  });
                  user.updatePassword(_userController.text).then(
                          (_){_userController.text="";
                      Navigator.of(context, rootNavigator: true).pop();}
                  );
                }
              })
        ],
      ), context: context,
    );
  }
  _updateName() async {
    await showDialog<String>(
      builder: (context) => new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: TextField(
                controller: _nameController,
                decoration: new InputDecoration(
                    errorText: _validate ? "Không hợp lệ" : null,
                    labelText: "Chỉnh sửa thông tin"),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Thoát'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              }),
          new FlatButton(
              child: const Text('Xác nhận'),
              onPressed: () {

                if(_nameController.text.length<6)
                {
                  _validate =true;
                }
                else{
                  _validate=false;
                  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                  User user = firebaseAuth.currentUser;
                  var uid = user.uid;
                  DatabaseReference databaseReference= FirebaseDatabase.instance.reference().child("Users");
                  databaseReference.child(uid).update({
                    'name': _nameController.text
                  }).then((_){
                    Navigator.of(context, rootNavigator: true).pop();
                    setState(() {
                      name = _nameController.text;
                      _nameController.text="";
                    });
                  });
                }
              })
        ],
      ), context: context,
    );
  }
  _updatePhone() async {
    await showDialog<String>(
      builder: (context) => new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: new InputDecoration(
                    errorText: _validate ? "Không hợp lệ" : null,
                    labelText: "Chỉnh sửa thông tin"),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Thoát'),
              onPressed: () {
                _phoneController.text="";
                Navigator.of(context, rootNavigator: true).pop();
              }),
          new FlatButton(
              child: const Text('Xác nhận'),
              onPressed: () {

                if(_phoneController.text.length<6)
                {
                  _validate =true;
                }
                else{
                  _validate=false;
                  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                  User user = firebaseAuth.currentUser;
                  var uid = user.uid;
                  DatabaseReference databaseReference= FirebaseDatabase.instance.reference().child("Users");
                  databaseReference.child(uid).update({
                    'phone': _phoneController.text
                  }).then((_){
                    Navigator.of(context, rootNavigator: true).pop();
                    setState(() {
                      phone = _phoneController.text;
                      _phoneController.text="";
                    });
                  });
                }
              })
        ],
      ), context: context,
    );
  }

}
