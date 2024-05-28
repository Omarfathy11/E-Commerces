class Product {
  int? id;
  String? name;
  String? description;
  double? price; // Change the type to double?
  bool? onSale;
  String? image;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.onSale,
    this.image,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    onSale = json['on_sale'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['on_sale'] = onSale;
    data['image'] = image;

    return data;
  }
}