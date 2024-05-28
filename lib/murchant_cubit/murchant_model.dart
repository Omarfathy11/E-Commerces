class MerchantModel {
  int? id;
  String? logo;
  String? image;
  String? taxId;
  Merchant? merchant;
  String? aboutUs;
  String? twitterUrl;
  String? websiteUrl;
  String? facebookUrl;
  String? linkedinUrl;
  String? returnPolicy;
  String? instagramUrl;
  String? shippingAddress;
  String? shippingOptions;
  String? merchantZipCode;

  MerchantModel(
      {this.id,
      this.logo,
      this.image,
      this.taxId,
      this.merchant,
      this.aboutUs,
      this.twitterUrl,
      this.websiteUrl,
      this.facebookUrl,
      this.linkedinUrl,
      this.returnPolicy,
      this.instagramUrl,
      this.shippingAddress,
      this.shippingOptions,
      this.merchantZipCode});

  MerchantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    image = json['image'];
    taxId = json['tax_id'];
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    aboutUs = json['about_us'];
    twitterUrl = json['twitter_url'];
    websiteUrl = json['website_url'];
    facebookUrl = json['facebook_url'];
    linkedinUrl = json['linkedin_url'];
    returnPolicy = json['return_policy'];
    instagramUrl = json['instagram_url'];
    shippingAddress = json['shipping_address'];
    shippingOptions = json['shipping_options'];
    merchantZipCode = json['merchant_zip_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['image'] = this.image;
    data['tax_id'] = this.taxId;
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    data['about_us'] = this.aboutUs;
    data['twitter_url'] = this.twitterUrl;
    data['website_url'] = this.websiteUrl;
    data['facebook_url'] = this.facebookUrl;
    data['linkedin_url'] = this.linkedinUrl;
    data['return_policy'] = this.returnPolicy;
    data['instagram_url'] = this.instagramUrl;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_options'] = this.shippingOptions;
    data['merchant_zip_code'] = this.merchantZipCode;
    return data;
  }
}

class Merchant {
  int? id;
  String? email;
  String? phoneNumber;
  String? address;
  String? paymentInformation;
  bool? termsAgreement;
  String? businessName;

  Merchant(
      {this.id,
      this.email,
      this.phoneNumber,
      this.address,
      this.paymentInformation,
      this.termsAgreement,
      this.businessName});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    paymentInformation = json['payment_information'];
    termsAgreement = json['terms_agreement'];
    businessName = json['business_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['payment_information'] = this.paymentInformation;
    data['terms_agreement'] = this.termsAgreement;
    data['business_name'] = this.businessName;
    return data;
  }
}