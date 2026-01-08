import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;
  var isLoading = false.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }

  void reset() {
    count.value = 0;
  }

  // Simulate async operation
  Future<void> incrementAsync() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 1));
    count.value++;
    isLoading.value = false;
  }

  // Computed property
  String get counterText {
    if (count.value == 0) return 'Zero';
    if (count.value == 1) return 'One';
    return count.value.toString();
  }

  // Validation
  bool get canDecrement => count.value > 0;
}