

import 'package:agent_management/models/models.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {

  bool _isLoading = false;
  bool _isSuccess = false;
  List<Product> _products  = [];
  Product _product = new Product.empty();

  bool get isLoading => _isLoading;
  set isLoading(bool data){
    this._isLoading = data;
    notifyListeners();
  }

  bool get isSuccess => _isSuccess;
  set isSuccess(bool data){
    this._isSuccess = data;
    notifyListeners();
  }

  List<Product> get products => _products;
  set products(List<Product> data){
    this._products = data;
    this.isSuccess = true;
    notifyListeners();
  }

  Product get product => _product;
  set product(Product data) {
    this._product = data;
    notifyListeners();
  }

}