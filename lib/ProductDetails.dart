import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/fetchData.dart';
import 'package:shop/provider/addProduct_provider.dart';

import 'model/products.dart';

class productDetails extends StatelessWidget {
  const productDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      final todo = ModalRoute.of(context)!.settings.arguments as Products;
      ProductProvider productProvider = Provider.of<ProductProvider>(context);
      int index;
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey,
          width: double.infinity,
          height: double.infinity,
          child: Card(
            color: Colors.grey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 30,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 280,
                      ),
                      GestureDetector(
                        child: CircleAvatar(
                          child: Icon(
                            Icons.favorite,
                            size: 30,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                        ),
                        onTap: () {
                          Products favouriteProduct = new Products(
                            id: todo.id,
                            price: todo.price,
                            title: todo.title,
                            image: todo.image,
                            description: todo.description,
                            category: todo.category,
                          );
                          productProvider.addProductToFav(favouriteProduct);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        // Provider.of<ProductProvider>(context,listen: false).cart[index].image,
                        todo.image,
                        height: 300,
                        width: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                    radius: 150,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          todo.title,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25,0,0.0,0.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('${todo.price.toString()} \$',style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                          text: "Details \n",
                            style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.normal),
                         children:<TextSpan>[
                           TextSpan(
                               text: todo.description, style: TextStyle(fontWeight: FontWeight.normal,
                               color: Colors.black38)),
                         ],
                         // maxLines: 10,
                        ),
                          maxLines: 10,
                      ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "Category \n",
                            style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.normal),
                            children:<TextSpan>[
                              TextSpan(
                                  text: todo.category, style: TextStyle(fontWeight: FontWeight.normal,
                                  color: Colors.black38)),
                            ],
                            // maxLines: 10,
                          ),
                          maxLines: 10,
                        ),
                      ),
                      SizedBox(width: 40,),
                      CircleAvatar(
                        child: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          iconSize: 25,
                          color: Colors.black,
                          onPressed: () {
                            Products cartProduct = new Products(
                              id: todo.id,
                              price: todo.price,
                              title: todo.title,
                              image: todo.image,
                              description: todo.description,
                              category: todo.category,
                            );
                            productProvider.addProductToCarts(cartProduct);
                          },
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
