class CartModel {
  int? id;
  int? itemQuantity;
  Product? product;

  CartModel({this.id, this.itemQuantity, this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemQuantity = json['item_quantity'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_quantity'] = this.itemQuantity;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  double? price;
  Merchant? merchant;
  String? image;

  Product({this.id, this.name, this.price, this.merchant, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Merchant {
  String? businessName;

  Merchant({this.businessName});

  Merchant.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    return data;
  }
}