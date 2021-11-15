

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:agent_management/models/models.dart';

class ProductProvider with ChangeNotifier {
  
  bool _isLoading = false;
  bool _isSuccess = false;
  bool _isUpdating = false;
  bool _isChangePhoto = false;
  File _photo = new File('');
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

  bool get isUpdating => _isUpdating;
  set isUpdating(bool data){
    this._isUpdating = data;
    notifyListeners();
  }

  bool get isChangePhoto => _isChangePhoto;
  set isChangePhoto(bool data) {
    this._isChangePhoto = data;
    notifyListeners();
  }

  File get photo => _photo;
  set photo(File data) {
    this._photo = data;
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