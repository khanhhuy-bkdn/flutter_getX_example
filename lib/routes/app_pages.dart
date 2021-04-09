import 'package:flutter_demo_getx/pages/login/bindings/login_binding.dart';
import 'package:flutter_demo_getx/pages/login/views/SignIn_screen.dart';
import 'package:flutter_demo_getx/pages/proposal/bindings/proposal_binding.dart';
import 'package:flutter_demo_getx/pages/proposal/bindings/proposal_detail_binding.dart';
import 'package:flutter_demo_getx/pages/proposal/views/details/proposal_detail_view.dart';
import 'package:flutter_demo_getx/pages/proposal/views/propasal_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static final initRouter = GetStorage().read('token') == null
      ? Routes.login
      : Routes.purchaseProposal;

  static final routes = [
    GetPage(
        name: Routes.login,
        page: () => SignInScreen(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.purchaseProposal,
        page: () => ProposalView(),
        binding: ProposalBinding(),
        children: [
          GetPage(
            name: Routes.purchaseProposalDetail,
            page: () => ProposalDetailView(),
            binding: ProposalDetailBinding(),
          )
        ]),
  ];
}
