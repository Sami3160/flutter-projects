import 'package:get/get.dart';
import 'package:azure_chatbot/app/core/base/base_controller.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});
}
