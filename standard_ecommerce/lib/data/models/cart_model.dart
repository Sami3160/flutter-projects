

import 'package:json_annotation/json_annotation.dart';
import 'package:standard_ecommerce/domain/entities/cart.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel extends Cart{

  CartModel({
    required super.id,
    required super.products,
    required super.total,
    required super.discountedTotal,
    required super.userId,
    required super.totalProducts,
    required super.totalQuantity,
  });
  
  factory CartModel.fromJson(Map<String, dynamic> json)=>_$CartModelFromJson(json);
    @override
  Map<String, dynamic > toJson()=>_$CartModelToJson(this);
}