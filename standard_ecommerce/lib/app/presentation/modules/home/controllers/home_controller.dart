import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_ecommerce/app/domain/entities/product.dart';
import 'package:standard_ecommerce/app/domain/usecases/get_products_usecase.dart';
import 'package:standard_ecommerce/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final GetProductsUseCase getProductsUseCase;
  final SearchProductsUseCase searchProductsUseCase;

  HomeController(this.getProductsUseCase, this.searchProductsUseCase);

  final products = <Product>[].obs;
  final isLoading = true.obs;
  final searchController = TextEditingController();

  // Sort options
  final sortByPriceAsc = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      products.value = await getProductsUseCase();
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to load products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      fetchProducts();
      return;
    }
    try {
      isLoading.value = true;
      products.value = await searchProductsUseCase(query);
    } catch (e) {
      Get.snackbar('Error', 'Search failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void sortProducts() {
    sortByPriceAsc.toggle();
    if (sortByPriceAsc.value) {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else {
      products.sort((a, b) => b.price.compareTo(a.price));
    }
  }

  void goToCart() {
    Get.toNamed(Routes.CART);
  }
}
