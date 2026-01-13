import 'package:assigment_1/core/services/auth_service.dart';
import 'package:assigment_1/core/services/stoarge_service.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(StorageService(), permanent: true);
    Get.put(AuthService(), permanent: true);
  }
}