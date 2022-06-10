class ProductList {
  String? productName;
  double? productRate;
  String? description;
  String? price;
  String? productImage;

  ProductList({
    this.productName,
    this.productRate,
    this.description,
    this.price,
    this.productImage,
  });

  factory ProductList.fromJson(Map<String, dynamic> jsonData) {
    return ProductList(
      productName: jsonData['productName'],
      productRate: jsonData['productRate'],
      description: jsonData['description'],
      price: jsonData['price'],
      productImage: jsonData['productImage'],
    );
  }
}
