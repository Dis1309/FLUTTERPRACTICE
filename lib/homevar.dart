import 'package:flutter/material.dart';

class MyHomePageState extends ChangeNotifier {
var counter = 0;
var list = <int>[];
  
void nw() {
    if(list.contains(counter)){
      list.remove(counter);
    }else {
      list.add(counter);
    }
    notifyListeners();
  }
  
void  incrementCounter() {
      counter++;
      notifyListeners();
    
  }

void  decrementCounter() {
      counter--;
      notifyListeners();
    
  }
}