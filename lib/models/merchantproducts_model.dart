class merchantproduct {
  int? id;
  String? barCode;
  String? name;
  String? description;
  String? price;
  int? quantity;
  String? image;
  bool? available;
  bool? onSale;
  String? salePercent;
  String? priceAfterSale;
  

  merchantproduct(
      {this.id,
      this.barCode,
      this.name,
      this.description,
      this.price,
      this.quantity,
      this.image,
      this.available,
      this.onSale,
      this.salePercent,
      this.priceAfterSale,
      });

  merchantproduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barCode = json['bar_code'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
    available = json['available'];
    onSale = json['on_sale'];
    salePercent = json['sale_percent'];
    priceAfterSale = json['price_after_sale'];
    
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bar_code'] = barCode;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['quantity'] = quantity;
    data['image'] = image;
    data['available'] = available;
    data['on_sale'] = onSale;
    data['sale_percent'] = salePercent;
    data['price_after_sale'] = priceAfterSale;
    
    return data;
  }
}