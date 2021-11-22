
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

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

  static Future<bool> updateProduct(Product product, String token) async {

    try {

      String userID = await UserService.readUserID();

      Uri url = Uri.parse('${Environment.apiProductsUrl}/$userID/${product.code}');
      
      final resp = await http.put(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
          'x-token'      : token
        },
        body: jsonEncode(product.toJsonServices())
      );

      return resp.statusCode == 200;

    } catch (err) {
      print('Error $err');
      return false;
    }

  }

  static Future<bool> deleteProduct(String code, String token) async {

    try {

      if(code == 'no-code') return false;

      String userID = await UserService.readUserID();

      Uri url = Uri.parse('${Environment.apiProductsUrl}/$userID/$code');
      
      final resp = await http.delete(url,
        headers: {
          'x-token' : token
        }
      );

       return resp.statusCode == 200;

    } catch (err) {
      print('Error $err');
      return false;
    }

  }

  static Future<bool> uploadImage(String code, File photo, String token) async {

    try {

      if(code == '') return false;

      String userID = await UserService.readUserID();

      Uri url = Uri.parse('${Environment.apiUploadProductsUrl}/$code?userID=$userID');
      final mimeType = mime(photo.path)!.split('/');
      
      final imageUploadRequest = http.MultipartRequest(  
        'PUT',
        url
      );

      final file = await http.MultipartFile.fromPath(
        'file', 
        photo.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );

      imageUploadRequest.files.add(file);
      imageUploadRequest.headers.addAll({
        'x-token' : token
      });

      final streamResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);
      
      return resp.statusCode == 200;

    } catch (err) {
      print('error: $err');
      return false;
    }
  }
}