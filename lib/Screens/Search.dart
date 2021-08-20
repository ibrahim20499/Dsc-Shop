import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/addProduct_provider.dart';

import 'Favourite.dart';
import 'ProductDetails.dart';
import '../model/fetchData.dart';
import '../model/products.dart';

class SearchUser extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
      ProductProvider productProvider = Provider.of<ProductProvider>(context);

      return FutureBuilder<List<Products>>(
      future: FetchData().getData(query: query),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          List<Products>? data = snapShot.data;
          return ListView.builder(
            itemCount: snapShot.data!.length,
            itemBuilder: (context, index) {
                return Expanded(
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(5.0),
                        height: 160,
                        child: GestureDetector(
                            child: Flexible(
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.white,
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            IconButton(
                                                icon: Icon(Icons.favorite),
                                                iconSize: 25,
                                                color: Colors.black,
                                                onPressed: () {
                                                    Products favProduct = new Products(
                                                        id: snapShot.data![index].id,
                                                        category: snapShot.data![index].category,
                                                        image: snapShot.data![index].image,
                                                        description:
                                                        snapShot.data![index].description,
                                                        price: snapShot.data![index].price,
                                                        title: snapShot.data![index].title,
                                                    );
                                                    productProvider.addProductToFav(favProduct);
                                                }),
                                            Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                    child: ClipOval(
                                                        child: Image.network(
                                                            snapShot.data![index].image,
                                                            height: 150,
                                                            width: 150,
                                                            fit: BoxFit.fill,
                                                            //color: Colors.white,
                                                        ),
                                                    ),
                                                    radius: 60,
                                                ),
                                            ),
                                            // SizedBox(
                                            //   width: 15,
                                            // ),
                                            Expanded(
                                                child: Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: Column(
                                                        children: [
                                                            Expanded(
                                                                child: Text(
                                                                    snapShot.data![index].title,
                                                                    style: TextStyle(
                                                                        fontSize: 12, color: Colors.black),
                                                                    textAlign: TextAlign.justify,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    maxLines: 4,
                                                                ),
                                                            ),

                                                            // SizedBox(
                                                            //   height: 2.0,
                                                            // ),
                                                            Row(
                                                                children: [
                                                                    IconButton(
                                                                        icon: Icon(Icons.add_shopping_cart),
                                                                        iconSize: 25,
                                                                        color: Colors.blue,
                                                                        onPressed: () {
                                                                            Products cartProduct = new Products(
                                                                                id: snapShot.data![index].id,
                                                                                category: snapShot.data![index].category,
                                                                                image: snapShot.data![index].image,
                                                                                description:
                                                                                snapShot.data![index].description,
                                                                                price: snapShot.data![index].price,
                                                                                title: snapShot.data![index].title,
                                                                            );
                                                                            productProvider.addProductToCarts(cartProduct);                                        },
                                                                    ),
                                                                    SizedBox(
                                                                        width: 55,
                                                                    ),
                                                                    Text(
                                                                        "${snapShot.data![index].price} \$",
                                                                        style: TextStyle(color: Colors.black),
                                                                    )
                                                                ],
                                                            )
                                                        ],
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const productDetails(),
                                        settings: RouteSettings(
                                            arguments: snapShot.data![index],
                                        ),
                                    ),
                                );
                            },
                        ),
                    ),
                );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Products'),
    );
  }
}
