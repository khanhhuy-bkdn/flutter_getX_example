import 'package:flutter_demo_getx/pages/proposal/controllers/proposal_controller.dart';
import 'package:get/get.dart';

class ProposalDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProposalController(proposalRepository: Get.find()));
  }
}
