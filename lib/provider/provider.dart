import 'package:flutter/cupertino.dart';

class ShopProvider extends ChangeNotifier {
  var products = [];
  var total = 0;

  void addItem(item){
    products.add(item);
    total = products.length;
    notifyListeners();
    print(products.length);
  }

  void removeItem(item){
    products.remove(item);
     total = products.length;
    notifyListeners();
    print(products.length);
  }
}