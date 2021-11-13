

import 'package:agent_management/models/models.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {

  bool _isLoading = false;
  List<Product> _products  = [];
  Product _product = new Product.empty();

  bool get isLoading => _isLoading;
  set isLoading(bool data){
    this._isLoading = data;
    notifyListeners();
  }

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