
import 'package:app_doc_truyen/dialog/loading_dialog.dart';
import 'package:app_doc_truyen/dialog/msg_dialog.dart';
import 'package:app_doc_truyen/scr/Users/login_page.dart';
import 'package:app_doc_truyen/scr/blocs/sign_up_bloc.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpBloc bloc = new SignUpBloc();

  TextEditingController _userController = new TextEditingController();

  TextEditingController _passController = new TextEditingController();

  TextEditingController _phoneController = new TextEditingController();

  TextEditingController _nameController = new TextEditingController();

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
              image:new AssetImage("images/1.png"), fit: BoxFit.cover),
          gradient: LinearGradient(
              colors: [Colors.blue[400], Colors.blue],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 70,),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Create Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: StreamBuilder(
                stream: bloc.nameStream,
                builder:(context,snapshots)=> TextField(
                  controller: _nameController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      errorText: snapshots.hasError ? snapshots.error:null,
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      hintText: "Enter your name",
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
              ),
            ),
                SizedBox(
                  height: 15,
                ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: StreamBuilder<Object>(
                stream: bloc.userStream,
                builder: (context, snapshots) {
                  return TextField(
                    controller: _userController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        errorText: snapshots.hasError ? snapshots.error:null,
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintText: "Enter your Email",
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
                  );
                }
              ),
            ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: StreamBuilder<Object>(
                    stream: bloc.phoneStream,
                    builder: (context, snapshots) {
                      return TextField(
                        controller: _phoneController,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            errorText: snapshots.hasError ? snapshots.error:null,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: "Enter your phone",
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
                      );
                    }
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: StreamBuilder<Object>(
                    stream: bloc.passStream,
                    builder: (context, snapshots) {
                      return TextField(
                        obscureText: true,
                        controller: _passController,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(

                            errorText: snapshots.hasError ? snapshots.error:null,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: "Enter your password",
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
                      );
                    }
                  ),
                ),
                SizedBox(
                  height: 25,
                ),  Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
                  child: ButtonTheme(
                      buttonColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55,
                      child: RaisedButton(
                        onPressed: _onSignUpClicked,
                        child: Text(
                          'Create',
                          style: TextStyle(color: Colors.grey, fontSize: 22),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _onSignUpClicked(){
    var isValid =bloc.isValidInfo(_userController.text, _passController.text, _phoneController.text,_nameController.text);
    if(isValid)
    {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      bloc.signUp(_userController.text, _passController.text, _phoneController.text,_nameController.text ,(){
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
      },(msg){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign Up", msg);
      });
    }
  }
}
