import 'package:standard_ecommerce/app/data/models/product_model.dart';
import 'package:standard_ecommerce/app/data/providers/api_provider.dart';
import 'package:standard_ecommerce/app/domain/entities/product.dart';
import 'package:standard_ecommerce/app/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiProvider provider;

  ProductRepositoryImpl({required this.provider});

  @override
  Future<List<Product>> getProducts() async {
    final response = await provider.getProducts();
    // print(response.body);
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    List<dynamic> productsJson = response.body['products'];
    // print(ProductModel.fromJson(productsJson[16]).id);
    return productsJson.map((json) {
      final model = ProductModel.fromJson(json);
      // print(model.id);
      return _mapToEntity(model);
    }).toList();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final response = await provider.searchProducts(query);
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    List<dynamic> productsJson = response.body['products'];
    return productsJson.map((json) {
      final model = ProductModel.fromJson(json);
      return _mapToEntity(model);
    }).toList();
  }

  Product _mapToEntity(ProductModel model) {
    return Product(
      id: model.id ?? 0,
      title: model.title ?? 'No Title',
      description: model.description ?? '',
      price: model.price ?? 0.0,
      discountPercentage: model.discountPercentage ?? 0.0,
      rating: model.rating ?? 0.0,
      stock: model.stock ?? 0,
      brand: model.brand ?? 'Generic',
      category: model.category ?? 'Uncategorized',
      thumbnail: model.thumbnail ?? '',
      images: model.images ?? [],
    );
  }
}
