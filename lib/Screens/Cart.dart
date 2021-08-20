import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/addProduct_provider.dart';

import 'ProductDetails.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: productProvider.cartProduct.length,
        itemBuilder: (context, index) {
          return Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(5.0),
              height: 160,
              child: GestureDetector(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              productProvider.cartProduct[index].image,
                              height: 150,
                              width: 150,
                              fit: BoxFit.fill,
                            ),
                          ),
                          radius: 60,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productProvider.cartProduct[index].title,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                                maxLines: 4,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${productProvider.cartProduct[index].price} \$",
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                color: Colors.black12,
                                width: 70,
                                height: 35,
                                child: IconButton(
                                  onPressed: () {
                                    productProvider.cartProduct.removeAt(index);
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.delete, size: 25,color: Colors.black,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const productDetails(),
                      settings: RouteSettings(
                        arguments: productProvider.cartProduct[index],
                      ),
                    ),
                  );

                },
              ),
            ),
          );
        },
      ),
    );
  }
}
