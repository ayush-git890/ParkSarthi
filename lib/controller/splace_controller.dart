import 'package:ParkSarthi/pages/lohninscreen.dart';
import 'package:get/get.dart';

class SplaceController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    pageHander();
  }

  void pageHander() async {
    Future.delayed(
      const Duration(seconds: 6),
      () {
        Get.offAllNamed("/map-page");
        Get.offAll(const LoginSignupEmail());
        update();
      },
    );
  }
}
