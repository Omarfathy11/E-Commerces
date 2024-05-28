class productmerchant {
  String? message;
  Product? product;

  productmerchant({this.message, this.product});

  productmerchant.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  String? price;
  String? image;
  bool? available;
  bool? onSale;
  
  List<Null>? colors;
  List<Null>? images;
  List<Null>? reviews;
  Merchant? merchant;
  String? barCode;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.image,
      this.available,
      this.onSale,
     
      this.images,
      this.reviews,
      this.merchant,
      this.barCode});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    available = json['available'];
    onSale = json['on_sale'];
   
   
   
  
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    barCode = json['bar_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['available'] = this.available;
    data['on_sale'] = this.onSale;
   
   
    
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    data['bar_code'] = this.barCode;
    return data;
  }
}

class Merchant {
  String? merchantName;
  String? phone;
  String? address;

  Merchant({this.merchantName, this.phone, this.address});

  Merchant.fromJson(Map<String, dynamic> json) {
    merchantName = json['merchant_name'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_name'] = this.merchantName;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
