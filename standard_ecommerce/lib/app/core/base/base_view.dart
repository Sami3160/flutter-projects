import 'package:get/get.dart';
import 'package:standard_ecommerce/app/core/base/base_controller.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});
}
