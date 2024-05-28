class UserModel {
  int? id;
  Customer? customer;
  Null? bio;
  String? image;

  UserModel({this.id, this.customer, this.bio, this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    bio = json['bio'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['bio'] = this.bio;
    data['image'] = this.image;
    return data;
  }
}

class Customer {
  int? id;
  String? email;
  String? address;
  String? fullName;
  String? phoneNumber;

  Customer(
      {this.id, this.email, this.address, this.fullName, this.phoneNumber});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    address = json['address'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['address'] = this.address;
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}