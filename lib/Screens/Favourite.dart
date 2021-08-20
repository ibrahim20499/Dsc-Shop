import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/addProduct_provider.dart';

import 'ProductDetails.dart';
import '../model/products.dart';

class Favourite extends StatelessWidget {
  // Favourite({Key? key, required this.index, required this.items})
  //     : super(key: key);
  //
  // List<Products> items;
  // int index;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount:productProvider.favouriteProduct.length,
        itemBuilder: (context, index) {
          return Container(
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
                              productProvider.favouriteProduct[index].image,
                            height: 150,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                        radius: 60,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                productProvider.favouriteProduct[index].title,
                                style: TextStyle(fontSize: 12, color: Colors.black),
                                maxLines: 4,
                              ),
                            ),
                             SizedBox(
                               height: 5,
                             ),
                            Expanded(
                              child: Text(
                               '${productProvider.favouriteProduct[index].price.toString()} \$',
                               textAlign: TextAlign.start,
                               style: TextStyle(color: Colors.red),
                                ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    color: Colors.black12,
                                    width: 70,
                                    height: 33,
                                    child: IconButton(
                                      icon: Icon(Icons.add_shopping_cart),
                                      iconSize: 25,
                                      color: Colors.black,
                                      onPressed: () {
                                        Products crtProduct = new Products(
                                          id: productProvider.FavProduct![index].id,
                                          category: productProvider.FavProduct![index].category,
                                          image: productProvider.FavProduct![index].image,
                                          description: productProvider.FavProduct![index].description,
                                          price: productProvider.FavProduct![index].price,
                                          title: productProvider.FavProduct![index].title,
                                        );
                                        productProvider.addProductToCarts(crtProduct);
                                      },
                                    ),
                                  ),
                                  //SizedBox(width: 5,),
                                  SizedBox(width: 20,),
                                  Container(
                                    color: Colors.black12,
                                    width: 70,
                                    height: 35,
                                    child: IconButton(
                                      onPressed: () {
                                        productProvider.favouriteProduct.removeAt(index);
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.delete, size: 25,color: Colors.black,),
                                    ),
                                  ),
                                ],
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
                        builder: (context) => productDetails(),
                      settings: RouteSettings(
                        arguments: productProvider.favouriteProduct![index],
                    ),
                    ));
              },
            ),
          );
        },
      ),
    );
  }
}
