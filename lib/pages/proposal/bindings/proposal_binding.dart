import 'package:flutter_demo_getx/pages/proposal/controllers/filter_proposal_controller.dart';
import 'package:flutter_demo_getx/pages/proposal/controllers/proposal_controller.dart';
import 'package:flutter_demo_getx/services/repository/infrastructure/proposal/proposal_repository.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/proposal/i_proposal_repository.dart';
import 'package:get/get.dart';

class ProposalBinding extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut<IHomeProvider>(() => HomeProvider());
    Get.lazyPut<IProposalRepository>(
        () => ProposalRepository(apiProvider: Get.find()));
    Get.lazyPut(() => FilterProposalController(proposalRepository: Get.find()));
    Get.lazyPut(() => ProposalController(proposalRepository: Get.find()));
  }
}
