class CartItem {
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    this.thumbnail,
  });

  int id;
  String title;
  double price;
  int quantity;
  double total;
  double discountPercentage;
  double discountedTotal;
  String? thumbnail;

  factory CartItem.fromJson(Map<String, dynamic>? json) {
    return CartItem(
      id: json?['id'] as int? ?? 0,
      title: json?['title'] as String? ?? '',
      price: (json?['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json?['quantity'] as int? ?? 0,
      total: (json?['total'] as num?)?.toDouble() ?? 0.0,
      discountPercentage: (json?['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      discountedTotal: (json?['discountedTotal'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json?['thumbnail'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'quantity': quantity,
    'total': total,
    'discountPercentage': discountPercentage,
    'discountedTotal': discountedTotal,
    'thumbnail': thumbnail,
  };
}

class Cart {
  Cart({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  int id;
  List<CartItem> products;
  double total;
  double discountedTotal;
  int userId;
  int totalProducts;
  int totalQuantity;

  factory Cart.fromJson(Map<String, dynamic>? json) {
    return Cart(
      id: json?['id'] as int? ?? 0,
      products: (json?['products'] as List?)
          ?.map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
      total: (json?['total'] as num?)?.toDouble() ?? 0.0,
      discountedTotal: (json?['discountedTotal'] as num?)?.toDouble() ?? 0.0,
      userId: json?['userId'] as int? ?? 0,
      totalProducts: json?['totalProducts'] as int? ?? 0,
      totalQuantity: json?['totalQuantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'products': products.map((item) => item.toJson()).toList(),
    'total': total,
    'discountedTotal': discountedTotal,
    'userId': userId,
    'totalProducts': totalProducts,
    'totalQuantity': totalQuantity,
  };
}
