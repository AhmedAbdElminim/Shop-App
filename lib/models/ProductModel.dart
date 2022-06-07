class ProductModel {
  String? id;
  String? title;
  double? price;
  String? description;
  String? imageUrl;
  String? productCategoryName;
  String? brand;
  int? quantity;
  // final bool isfavorite;
  bool? isPopular;

  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.imageUrl,
      required this.productCategoryName,
      required this.brand,
      required this.quantity,
      // this.isfavorite,
      required this.isPopular});
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    brand = json['brand'];
    quantity = json['quantity'];
    productCategoryName = json['productCategoryName'];
    isPopular = json['isPopular'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'quantity': quantity,
      'productCategoryName': productCategoryName,
      'isPopular': isPopular,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
    };
  }

  /*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    data['isPopular'] = this.isPopular;
    data['productCategoryName'] = this.productCategoryName;
    data['id'] = this.id;
    data['brand'] = this.brand;



    return data;
  }*/
}
