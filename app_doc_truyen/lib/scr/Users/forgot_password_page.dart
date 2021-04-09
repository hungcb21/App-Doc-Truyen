import 'package:app_doc_truyen/dialog/loading_dialog.dart';
import 'package:app_doc_truyen/scr/blocs/sign_up_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  SignUpBloc bloc = new SignUpBloc();
  TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading:    InkWell(
            onTap: ()  {
          Navigator.pop(context);
            },
            child: Container(
              child: Icon(Icons.arrow_back,color: Colors.black,),
            ),
          ),
        ),
        body: Center(
          child: Container(
            color:Colors.white,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Text("Forgot Password?",style: TextStyle(fontSize: 30,color: Colors.black),),
                ),
                Container(
                    width: 212,
                    child: StreamBuilder(
                      stream: bloc.userStream,
                      builder: (context,snapshot)=>TextField(
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        controller: _emailController,
                        decoration: InputDecoration(labelText: "Email",
                            errorText: snapshot.hasError ? snapshot.error:null,
                            labelStyle:TextStyle( color: Colors.black,fontSize:18)),
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                      onPressed: _onResetPassClicked,
                      child: Text("Reset Password",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _onResetPassClicked(){
    LoadingDialog.showLoadingDialog(context, "Loading...");
    FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text).then((value){
      LoadingDialog.hideLoadingDialog(context);
      Navigator.pop(context);
    } );

  }
}
