
import 'dart:convert';
//import 'dart:js';
//import 'package:provider/provider.dart';

import 'package:shop/model/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shop/provider/addProduct_provider.dart';

class FetchData{

    Future<List<Products>> getData({required String query}) async {
        String url = 'https://fakestoreapi.com/products';
        var jsonData = await http.get(Uri.parse(url));
        if (jsonData.statusCode == 200) {
            List data = jsonDecode(jsonData.body);
            List<Products> allproducts = [];
            for (var u in data) {
                Products products = Products.fromjson(u);
                allproducts.add(products);
            }
            if(query !=null){
                allproducts =allproducts.where((element) =>
                    element.title.toLowerCase().contains(query.toLowerCase())).toList();
            }
            return allproducts;
        } else {
            throw Exception("error");
        }
    }}