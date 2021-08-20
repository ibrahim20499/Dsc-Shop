import 'dart:io';
import 'package:path/path.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop/Favourite.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/cloudStorage.dart';
import 'package:shop/model/products.dart';
import 'package:shop/model/fetchData.dart';
import 'package:flutter/material.dart';
import 'package:shop/provider/addProduct_provider.dart';
import 'package:shop/provider/change_theme.dart';
import 'Favourite.dart';
import 'Login.dart';
import 'ProductDetails.dart';
import 'Search.dart';
import 'model/products.dart';
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  File? file;
  UploadTask? uploadTask;
  String? url;
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchUser());
              },
              icon: Icon(Icons.search_sharp,size: 25,),
            )
          ],
        ),
        body: FutureBuilder<List<Products>>(
      future: FetchData().getData(query: ''),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          // List<Products> product = snapShot.data
          //     .where((element) => element.title==title).toList();
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
    ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Ibrahim Hassan",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              currentAccountPicture: InkWell(
              onTap: selectFile,
               child: url != null?CircleAvatar(
                 //backgroundColor: Colors.greenAccent[400],
                 radius: 75,
                 child: ClipOval(
                     child: Image.network(url!,
                   height: 150,
                   width: 150,
                   fit: BoxFit.fill,),
                 ),
               ):Container(child: Icon(Icons.photo_camera_outlined),),
                radius: 75,
                ), accountEmail: null,
            ),
            ListTile(
              title: Text(
                "Dark Mode",
                style: TextStyle(),
              ),
              trailing: ChangeThemeButtonWidget(),
              onTap: () {},
            ),
            ListTile(
              title:Text("Sign out",),
              onTap: () {
                logout(context);
              },
            ),
            //trailing: ChangeThemeButtonWidget(),
          ],
        ),
      ),
      );
  }

  void logout(BuildContext ctx) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(
      builder: (ctx) => LoginPage(),
    ));
  }

  Future selectFile() async{
   final result = await FilePicker.platform.pickFiles(allowMultiple: false);
   if(result==null) return;
   final path = result.files.single.path;
   setState(() {
     file =File(path!);
   });
   uploaFile();
  }
 Future uploaFile() async{
    if(file==null) return null;
    final fileName = basename(file!.path);
    final destination = 'images/$fileName';
    uploadTask = CloudStorage.uploadImage(destination, file!);
    if(uploadTask==null) return;
    final snapshot =await uploadTask!.whenComplete((){});
    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      url = urlDownload;
    });
  }
}
