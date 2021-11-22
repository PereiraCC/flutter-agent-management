
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agent_management/models/models.dart';
import 'package:agent_management/services/services.dart';
import 'package:agent_management/providers/providers.dart';

import 'package:agent_management/global/environment.dart';

class ProductsServices {

  static Future<bool> getAllProducts(BuildContext context) async {

    try {
      
      final productProvider = Provider.of<ProductProvider>(context, listen: false);
      String userID = await UserService.readUserID();

      final url = Uri.parse('${Environment.apiProductsUrl}/$userID');
      final resp = await http.get(url);

      if(resp.statusCode == 200){

        final decodedData = json.decode(resp.body);
        final products = Product.fromJsonList(decodedData['documents']);

        productProvider.products = products;

        return true;
      }

      return false;

    } catch (err) {
      print('Error $err');
      return false;
    }
  }

  static Future<bool> createProduct(Product product, String token) async {

    try {
      
      Uri url = Uri.parse('${Environment.apiProductsUrl}');

      final resp = await http.post(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
          'x-token'      : token
        },
        body: jsonEncode(product.toJsonServices())
      );

      return resp.statusCode == 201;

    } catch (err) {
      print('error: $err');
      return false;
    }

  }
}