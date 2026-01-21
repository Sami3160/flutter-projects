import 'package:standard_ecommerce/app/data/models/cart_model.dart';
import 'package:standard_ecommerce/app/data/providers/api_provider.dart';
import 'package:standard_ecommerce/app/domain/entities/cart.dart';
import 'package:standard_ecommerce/app/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final ApiProvider provider;

  CartRepositoryImpl({required this.provider});

  @override
  Future<Cart> addToCart(int userId, int productId, int quantity) async {
    // DummyJSON add to cart requires a list of products
    final productsPayload = [
      {'id': productId, 'quantity': quantity},
    ];

    final response = await provider.addToCart(userId, productsPayload);
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    final model = CartModel.fromJson(response.body);
    return _mapToEntity(model);
  }

  Future<List<Cart>> getCartByUser(int userId) async {
    final response = await provider.getCartByUser(userId);
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    final models = response.body['carts'] as List;
    print(models);
    return models.map((e) => _mapToEntity(CartModel.fromJson(e))).toList();
  }

  Cart _mapToEntity(CartModel model) {
    return Cart(
      id: model.id!,
      products: model.products!
          .map(
            (p) => CartProduct(
              id: p.id!,
              title: p.title!,
              price: p.price!,
              quantity: p.quantity!,
              total: p.total!,
              discountPercentage: p.discountPercentage!,
              discountedPrice: p.discountedPrice!,
            ),
          )
          .toList(),
      total: model.total!,
      discountedTotal: model.discountedTotal!,
      userId: model.userId!,
      totalProducts: model.totalProducts!,
      totalQuantity: model.totalQuantity!,
    );
  }
}
