class Order {
  int? id;
  Customer? customer;
  String? created;
  String? status;
  double? totalPrice;
  String? shippingAddress;
  String? paymentMethod;
  List<Items>? items;

  Order(
      {this.id,
      this.customer,
      this.created,
      this.status,
      this.totalPrice,
      this.shippingAddress,
      this.paymentMethod,
      this.items});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '');
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    created = json['created'];
    status = json['status'];
    totalPrice = json['total_price'];
    shippingAddress = json['shipping_address'];
    paymentMethod = json['payment_method'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['created'] = this.created;
    data['status'] = this.status;
    data['total_price'] = this.totalPrice;
    data['shipping_address'] = this.shippingAddress;
    data['payment_method'] = this.paymentMethod;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  String? fullName;
  String? phoneNumber;
  String? address;

  Customer({this.fullName, this.phoneNumber, this.address});

  Customer.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }
}

class Items {
  int? id;
  int? quantity;

  Product? product;

  Items({this.id, this.quantity, this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '');
    quantity = json['quantity'] is int ? json['quantity'] : int.tryParse(json['quantity']?.toString() ?? '');
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? price;
  String? image;

  Product({this.id, this.name, this.price, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '');
    name = json['name'];
    price = json['price'] is int ? json['price'] : int.tryParse(json['price']?.toString() ?? '');
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}