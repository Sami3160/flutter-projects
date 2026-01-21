import 'package:standard_ecommerce/app/domain/entities/product.dart';
import 'package:standard_ecommerce/app/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}

class SearchProductsUseCase {
  final ProductRepository repository;

  SearchProductsUseCase(this.repository);

  Future<List<Product>> call(String query) async {
    return await repository.searchProducts(query);
  }
}
