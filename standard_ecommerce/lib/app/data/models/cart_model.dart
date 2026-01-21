class CartModel {
  int? id;
  List<CartProductModel>? products;
  double? total;
  double? discountedTotal;
  int? userId;
  int? totalProducts;
  int? totalQuantity;

  CartModel({
    this.id,
    this.products,
    this.total,
    this.discountedTotal,
    this.userId,
    this.totalProducts,
    this.totalQuantity,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['products'] != null) {
      products = <CartProductModel>[];
      json['products'].forEach((v) {
        products!.add(CartProductModel.fromJson(v));
      });
    }
    total = json['total'];
    discountedTotal = json['discountedTotal'];
    userId = json['userId'];
    totalProducts = json['totalProducts'];
    totalQuantity = json['totalQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['discountedTotal'] = discountedTotal;
    data['userId'] = userId;
    data['totalProducts'] = totalProducts;
    data['totalQuantity'] = totalQuantity;
    return data;
  }
}

class CartProductModel {
  int? id;
  String? title;
  double? price;
  int? quantity;
  double? total;
  double? discountPercentage;
  double? discountedPrice;

  CartProductModel({
    this.id,
    this.title,
    this.price,
    this.quantity,
    this.total,
    this.discountPercentage,
    this.discountedPrice,
  });

  CartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
    discountPercentage = json['discountPercentage']?.toDouble();
    discountedPrice = (json['discountedPrice'] ?? json['discountedTotal'])
        ?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['quantity'] = quantity;
    data['total'] = total;
    data['discountPercentage'] = discountPercentage;
    data['discountedPrice'] = discountedPrice;
    return data;
  }
}
