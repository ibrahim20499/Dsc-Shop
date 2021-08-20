import 'package:flutter/cupertino.dart';
import 'package:shop/model/fetchData.dart';
import 'package:shop/model/products.dart';

class ProductProvider extends ChangeNotifier {

  List<Products> favouriteProduct = [];
  List<Products> cartProduct = [];

  void addProductToFav(Products products) {
    favouriteProduct.add(products);
    notifyListeners();
  }
  List<Products> get FavProduct {
    return favouriteProduct;
  }

  void addProductToCarts(Products products) {
    cartProduct.add(products);
    notifyListeners();
  }

  List<Products> get CartProduct {
    return cartProduct;
  }
}
