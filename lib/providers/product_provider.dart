

import 'package:agent_management/models/models.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {

  List<Product> _products  = [];
  Product _product = new Product.empty();

  List<Product> get products => _products;
  set products(List<Product> data){
    this._products = data;
    notifyListeners();
  }

  Product get product => _product;
  set product(Product data) {
    this._product = data;
    notifyListeners();
  }

}