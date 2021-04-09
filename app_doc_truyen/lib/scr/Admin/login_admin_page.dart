import 'package:app_doc_truyen/dialog/loading_dialog.dart';
import 'package:app_doc_truyen/dialog/msg_dialog.dart';
import 'package:app_doc_truyen/scr/Admin/menu_page.dart';
import 'package:app_doc_truyen/scr/blocs/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
class LoginAdmin extends StatefulWidget {
  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  @override
  _LoginAdminState createState() => _LoginAdminState();

  FirebaseAuth   _auth = FirebaseAuth.instance;
  FacebookLogin facebookSignIn = new FacebookLogin();
  String ten;
  LoginBloc bloc = new LoginBloc();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  User _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){Navigator.pop(context);},
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/1.png'), fit: BoxFit.cover),
          gradient: LinearGradient(
              colors: [Colors.blue[400], Colors.blue],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 180,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Sign in with your account',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 65,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: StreamBuilder(
                      stream: bloc.userStream,
                      builder: (context, snapshots) => TextField(
                        controller: _userController,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            errorText:
                            snapshots.hasError ? snapshots.error : null,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(
                                fontSize: 18,
                                letterSpacing: 1.5,
                                color: Colors.white70,
                                fontWeight: FontWeight.w900),
                            filled: true,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            fillColor: Colors.white.withOpacity(.3),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25),
                            )),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: StreamBuilder(
                      stream: bloc.passStream,
                      builder: (context, snapshots) => TextField(
                        controller: _passController,
                        obscureText: true,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            errorText:
                            snapshots.hasError ? snapshots.error : null,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontSize: 18,
                                letterSpacing: 1.5,
                                color: Colors.white70,
                                fontWeight: FontWeight.w900),
                            filled: true,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            fillColor: Colors.white.withOpacity(.3),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25),
                            )),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: ButtonTheme(
                      buttonColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55,
                      child: RaisedButton(
                        onPressed: onLoginCliked,
                        child: Text(
                          'Log in',
                          style: TextStyle(color: Colors.grey, fontSize: 22),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't Have an Accout ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onLoginCliked() {
    String email = _userController.text;
    String pass = _passController.text;
    var isValid = bloc.isValidInfo(_userController.text, _passController.text);
    if (bloc.isValidInfo(_userController.text, _passController.text)) {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      bloc.signIn(_userController.text, _passController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MenuAdmin()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Login", msg);
      });
    }
  }
}
