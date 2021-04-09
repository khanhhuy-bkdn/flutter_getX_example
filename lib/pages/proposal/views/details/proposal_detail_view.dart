import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/module_type_check.dart';
import 'package:flutter_demo_getx/pages/proposal/controllers/proposal_controller.dart';
import 'package:flutter_demo_getx/pages/proposal/views/details/widget/proposal_general_info_widget.dart';
import 'package:flutter_demo_getx/pages/proposal/views/details/widget/proposal_mechandise_list_widget.dart';
import 'package:flutter_demo_getx/pages/proposal/views/details/widget/proposal_other_info_widget.dart';
import 'package:flutter_demo_getx/pages/shares/group_button_approve.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';
import 'package:get/get.dart';

class ProposalDetailView extends StatefulWidget {
  @override
  _ProposalDetailViewState createState() => _ProposalDetailViewState();
}

class _ProposalDetailViewState extends State<ProposalDetailView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final int proposalId = Get.arguments;
    Get.find<ProposalController>().getProposal(proposalId);
  }

  Widget build(BuildContext context) {
    TabController _controller = new TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('PHIẾU ĐỀ NGHỊ MUA HÀNG'),
        backgroundColor: defaultBgColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        elevation: 0,
        bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelStyle:
                CustomTheme.subTitle2(context).apply(color: Colors.white),
            indicator: BoxDecoration(
                color: defaultBgColor,
                border:
                    Border(bottom: BorderSide(color: Colors.white, width: 4))),
            controller: _controller,
            tabs: [
              Tab(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Thông tin chung',
                    ),
                  ),
                ),
              ),
              Tab(
                text: 'Thông tin khác',
              )
            ]),
      ),
      body: Container(
          color: defaultBgScreen,
          width: double.infinity,
          padding: EdgeInsets.all(defaultPadding),
          child: GetBuilder<ProposalController>(builder: (proposalController) {
            if (proposalController.isLoadingProposal) {
              return Container(
                height: double.maxFinite,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()]),
              );
            }
            return Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: TabBarView(controller: _controller, children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          PurchaseProposalGeneralInfoWidget(
                              proposal: proposalController.proposal),
                          PurchaseProposalMechandiseListWidget(
                            items: proposalController.proposal!.proposalItems!,
                          ),
                          GroupButtonApproveWidget(
                              approveStatus:
                                  proposalController.proposal?.approveStatus,
                              isShowApprovalDetail: proposalController
                                  .proposal?.isShowApprovalDetail,
                              objectId: proposalController.proposal?.id,
                              type: ModuleTypeCheck.purchaseproposal)
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          PurchaseProposalOtherInfoWidget(
                              proposal: proposalController.proposal),
                          GroupButtonApproveWidget(
                              approveStatus:
                                  proposalController.proposal?.approveStatus,
                              isShowApprovalDetail: proposalController
                                  .proposal?.isShowApprovalDetail,
                              objectId: proposalController.proposal?.id,
                              type: ModuleTypeCheck.purchaseproposal)
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ]);
          })),
    );
  }
}
