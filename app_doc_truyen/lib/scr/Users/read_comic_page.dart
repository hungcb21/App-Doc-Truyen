import 'package:flutter/material.dart';
class ReadComic extends StatefulWidget {
  String stories,chapter;
  ReadComic(this.stories,this.chapter);
  @override
  _ReadComicState createState() => _ReadComicState();
}

class _ReadComicState extends State<ReadComic> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(widget.chapter,style: TextStyle(fontSize: 50,color: Colors.blue),),
                ),
                Text(widget.stories.replaceAll("  ",  "\n\n"),style: TextStyle(fontSize: 25),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
