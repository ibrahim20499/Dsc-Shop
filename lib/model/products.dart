import 'dart:convert';

List<Products>? postFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromjson(x)));
class Products{
    final id;
    final title;
    final price;
    final description;
    final category;
    final image;
    Products({
        this.id, this.title, this.price,
        this.description,
        this.category,
        this.image
    });
    factory Products.fromjson(Map<String , dynamic> parsedJson) {
        return Products(
            id: parsedJson['id'],
            title:parsedJson['title'],
            price: parsedJson['price'],
            description: parsedJson["description"],
            category: parsedJson["category"],
            image: parsedJson["image"]
        );
    }
}