import 'package:app_doc_truyen/scr/blocs/add_category_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  Query query;
  CategoryBloc bloc = new CategoryBloc();
  bool _validate = true;
  DatabaseReference ref = FirebaseDatabase.instance.reference().child("Category");
  TextEditingController categoryController = new TextEditingController();
  TextEditingController updateController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query= FirebaseDatabase.instance.reference().child("Category");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text("Category"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                  stream: bloc.categoryStream,
                  builder: (context , snapshot)=>TextField(
                    controller: categoryController,
                  decoration: InputDecoration(
                    errorText: snapshot.hasError ? snapshot.error:null,
                    hintText: "Danh mục"
                  ),
                  ),
                ),
                RaisedButton(
                  color:Colors.blue,
                  child: Text("Thêm"),
                  onPressed: onAddCategoryClick,
                ),
                Container(
                  height: 400,
                  child: FirebaseAnimatedList(  query: query,
                      itemBuilder:(BuildContext context,DataSnapshot snapshot, Animation<double> animation, int index){
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                child: Text(snapshot.value["CategoryName"]),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                child: Row(
                                  children: [
                                    InkWell(
                                        child: Icon(Icons.update)
                                    ,onTap: (){
                                      showDialog<String>(
                                        builder: (context) => new AlertDialog(
                                          contentPadding: const EdgeInsets.all(16.0),
                                          content: new Row(
                                            children: <Widget>[
                                              new Expanded(
                                                child: TextField(
                                                  controller: updateController,
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
                                                  updateController.text="";
                                                  Navigator.of(context, rootNavigator: true).pop();
                                                }),
                                            new FlatButton(
                                                child: const Text('Xác nhận'),
                                                onPressed: () {
                                                  if(updateController.text.length<6)
                                                  {
                                                    _validate =true;
                                                  }
                                                  else{
                                                    _validate=false;
                                                    DatabaseReference databaseReference= FirebaseDatabase.instance.reference().child("Category");
                                                    databaseReference.child(snapshot.key).update({
                                                      'CategoryName': updateController.text
                                                    }).then((_){
                                                      Navigator.of(context, rootNavigator: true).pop();
                                                      setState(() {
                                                        updateController.text="";
                                                      });
                                                    });
                                                  }
                                                })
                                          ],
                                        ), context: context,
                                      );
                                    },),
                                    InkWell(
                                      onTap: (){
                                        AlertDialog alert = AlertDialog(
                                          title: Text("Xóa danh mục"),
                                          content: Text("Bạn có muốn xóa danh mục ?"),
                                          actions: <Widget>[
                                            FlatButton(
                                                child: Text("Không"),
                                                onPressed: (){Navigator.of(context, rootNavigator: true).pop();}
                                            ),
                                            FlatButton(
                                              child: Text("Có"),
                                              onPressed:  () {
                                                ref.child(snapshot.key).remove();
                                                Navigator.of(context, rootNavigator: true).pop();},
                                            ),
                                          ],
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                        },
                                        child: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  onAddCategoryClick()
  {
    var ref = FirebaseDatabase.instance.reference().child("Category");
    var category ={"CategoryName":categoryController.text};
    ref.child(categoryController.text).set(category);
    categoryController.text="";
  }
}
