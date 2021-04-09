import 'dart:async';

import 'package:app_doc_truyen/scr/validators/validations.dart';

class ChapterBloc{
  StreamController _chapterNameController = new StreamController();
  StreamController _storiesController = new StreamController();
  Stream get storiesStream=>_storiesController.stream;
  Stream get authorStream =>_chapterNameController.stream;
  bool isValidInfo(String category,String author)
  {
    if(!Validations.isValidStories(category))
    {
      _storiesController.sink.addError("Nội dung truyện không hợp lệ");
      return false;
    }
    _storiesController.sink.add("Ok");
    if(!Validations.isValidAuthor(author))
    {
      _chapterNameController.sink.addError("Tên chương không hợp lệ");
      return false;
    }
    _chapterNameController.sink.add("Ok");
    return true;

  }
  void dispose(){
    _storiesController.close();
    _chapterNameController.close();
  }
}