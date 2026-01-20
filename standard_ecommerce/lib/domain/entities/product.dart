class Dimensions {
  Dimensions({required this.width, required this.height, required this.depth});

  double width;
  double height;
  double depth;

  factory Dimensions.fromJson(Map<String, dynamic>? json) {
    return Dimensions(
      width: (json?['width'] as num?)?.toDouble() ?? 0.0,
      height: (json?['height'] as num?)?.toDouble() ?? 0.0,
      depth: (json?['depth'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'width': width,
    'height': height,
    'depth': depth,
  };
}

class Review {
  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  int rating;
  String comment;
  DateTime date;
  String reviewerName;
  String reviewerEmail;

  factory Review.fromJson(Map<String, dynamic>? json) {
    return Review(
      rating: json?['rating'] as int? ?? 0,
      comment: json?['comment'] as String? ?? '',
      date: json?['date'] != null
          ? DateTime.parse(json?['date'] as String)
          : DateTime.now(),
      reviewerName: json?['reviewerName'] as String? ?? '',
      reviewerEmail: json?['reviewerEmail'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'rating': rating,
    'comment': comment,
    'date': date.toIso8601String(),
    'reviewerName': reviewerName,
    'reviewerEmail': reviewerEmail,
  };
}

class Meta {
  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  DateTime createdAt;
  DateTime updatedAt;
  String barcode;
  String qrCode;

  factory Meta.fromJson(Map<String, dynamic>? json) {
    return Meta(
      createdAt: json?['createdAt'] != null
          ? DateTime.parse(json?['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json?['updatedAt'] != null
          ? DateTime.parse(json?['updatedAt'] as String)
          : DateTime.now(),
      barcode: json?['barcode'] as String? ?? '',
      qrCode: json?['qrCode'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'barcode': barcode,
    'qrCode': qrCode,
  };
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.tags,
    required this.reviews,
    required this.thumbnail,
    required this.images,
  });

  int id;
  String title;
  String description;
  String category;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String sku;
  double weight;
  Dimensions dimensions;
  String warrantyInformation;
  String shippingInformation;
  String availabilityStatus;
  String returnPolicy;
  int minimumOrderQuantity;
  Meta meta;
  List<String> tags;
  List<Review> reviews;
  String thumbnail;
  List<String> images;

  factory Product.fromJson(Map<String, dynamic>? json) {
    return Product(
      id: json?['id'] as int? ?? 0,
      title: json?['title'] as String? ?? '',
      description: json?['description'] as String? ?? '',
      category: json?['category'] as String? ?? '',
      price: (json?['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json?['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json?['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json?['stock'] as int? ?? 0,
      brand: json?['brand'] as String? ?? '',
      sku: json?['sku'] as String? ?? '',
      weight: (json?['weight'] as num?)?.toDouble() ?? 0.0,
      dimensions: Dimensions.fromJson(
        json?['dimensions'] as Map<String, dynamic>?,
      ),
      warrantyInformation: json?['warrantyInformation'] as String? ?? '',
      shippingInformation: json?['shippingInformation'] as String? ?? '',
      availabilityStatus: json?['availabilityStatus'] as String? ?? '',
      returnPolicy: json?['returnPolicy'] as String? ?? '',
      minimumOrderQuantity: json?['minimumOrderQuantity'] as int? ?? 0,
      meta: Meta.fromJson(json?['meta'] as Map<String, dynamic>?),
      tags:
          (json?['tags'] as List?)?.map((item) => item as String).toList() ??
          [],
      reviews:
          (json?['reviews'] as List?)
              ?.map((item) => Review.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      thumbnail: json?['thumbnail'] as String? ?? '',
      images:
          (json?['images'] as List?)?.map((item) => item as String).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'price': price,
    'discountPercentage': discountPercentage,
    'rating': rating,
    'stock': stock,
    'brand': brand,
    'sku': sku,
    'weight': weight,
    'dimensions': dimensions.toJson(),
    'warrantyInformation': warrantyInformation,
    'shippingInformation': shippingInformation,
    'availabilityStatus': availabilityStatus,
    'returnPolicy': returnPolicy,
    'minimumOrderQuantity': minimumOrderQuantity,
    'meta': meta.toJson(),
    'tags': tags,
    'reviews': reviews.map((item) => item.toJson()).toList(),
    'thumbnail': thumbnail,
    'images': images,
  };
}
