import 'package:get/get.dart';

import '../../data_classes/user.dart';
import '../../data_classes/user_list.dart';
import '../../services/user_service.dart';

class ChooseAccountController extends GetxController {
  RxList<User> users = <User>[].obs;
  @override
  void onInit() async {
    await loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    Users usersTemp = await UserService().getUsers();
    users(usersTemp.users);
  }
}
