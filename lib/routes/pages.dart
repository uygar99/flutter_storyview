import 'package:get/get.dart';

import '../services/user_service.dart';
import '../views/choose_account/choose_account_controller.dart';
import '../views/choose_account/choose_account_view.dart';
import '../views/home/home_controller.dart';
import '../views/home/home_view.dart';
import '../views/stories/stories_controller.dart';
import '../views/stories/stories_view.dart';
import '../views/stories/story_show_controller.dart';
import '../views/stories/story_show_view.dart';
import 'routes.dart';

List<GetPage> appPages = [
  GetPage(
    name: Routes.home,
    page: () => const HomeView(),
    binding: BindingsBuilder(() {
      Get.put<HomeController>(HomeController());
      Get.lazyPut<UserService>(() => UserService());
    }),
  ),
  GetPage(
    name: Routes.chooseAccount,
    page: () => const ChooseAccountView(),
    binding: BindingsBuilder(() {
      Get.put<ChooseAccountController>(ChooseAccountController());
      Get.lazyPut<UserService>(() => UserService());
    }),
  ),
  GetPage(
    name: Routes.stories,
    page: () => const StoriesView(),
    binding: BindingsBuilder(() {
      Get.put<StoriesController>(StoriesController());
      Get.lazyPut<UserService>(() => UserService());
    }),
  ),
  GetPage(
    name: Routes.storyDetail,
    page: () => const StoryShowView(),
    binding: BindingsBuilder(() {
      Get.put<StoryDetailController>(StoryDetailController());
      Get.lazyPut<UserService>(() => UserService());
    }),
  ),
];
