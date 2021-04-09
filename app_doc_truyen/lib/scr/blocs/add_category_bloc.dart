import 'dart:async';

import 'package:app_doc_truyen/scr/validators/validations.dart';

class CategoryBloc{
  StreamController _categoryController = new StreamController();
  Stream get categoryStream=>_categoryController.stream;
  bool isValidInfo(String category)
  {
    if(!Validations.isValidCategory(category))
      {
        _categoryController.sink.addError("Tên danh mục không hợp lệ");
        return false;
      }
    _categoryController.sink.add("Ok");
    return true;

  }
  void dispose(){
    _categoryController.close();
  }
}