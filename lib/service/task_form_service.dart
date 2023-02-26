import 'package:flutter/material.dart';
class TaskFormService extends ChangeNotifier{

  String _title = '';
  String _description = '';
  bool _isSaving = false;

  String get title => _title;
  String get description => _description;
  bool get isSaving => _isSaving;

  set title(String value){
    _title = value;
    notifyListeners();
  }

  set description(String value){
    _description = value;
    notifyListeners();
  }

  set isSaving(bool value){
    _isSaving = value;
    notifyListeners();
  }
  

}