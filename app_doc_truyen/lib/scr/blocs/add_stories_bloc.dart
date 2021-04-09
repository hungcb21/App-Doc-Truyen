import 'dart:async';

import 'package:app_doc_truyen/scr/validators/validations.dart';

class StoriesBloc{
  StreamController _storiesController = new StreamController();
  StreamController _authorController = new StreamController();
  Stream get storiesStream=>_storiesController.stream;
  Stream get authorStream =>_authorController.stream;
  bool isValidInfo(String category,String author)
  {
    if(!Validations.isValidCategory(category))
    {
      _storiesController.sink.addError("Tên truyện không hợp lệ");
      return false;
    }
    _storiesController.sink.add("Ok");
    if(!Validations.isValidAuthor(author))
    {
      _authorController.sink.addError("Tên tác giả không hợp lệ");
      return false;
    }
    _authorController.sink.add("Ok");
    return true;

  }
  void dispose(){
    _storiesController.close();
    _authorController.close();
  }
}