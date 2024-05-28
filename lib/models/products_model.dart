 
class ProductModel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? image;
  bool? available;
  bool? onSale;
  Merchant? merchant;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.image,
      this.available,
      this.onSale,
      
      this.merchant});

  ProductModel.fromJson(Map<String, dynamic> json) {
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