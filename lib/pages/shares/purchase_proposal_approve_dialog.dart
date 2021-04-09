import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/module_type_check.dart';
import 'package:flutter_demo_getx/constants/status_message.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_approve.request.dart';
import 'package:flutter_demo_getx/pages/proposal/controllers/filter_proposal_controller.dart';
import 'package:flutter_demo_getx/pages/proposal/controllers/proposal_controller.dart';
import 'package:flutter_demo_getx/utils/function_helper.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';

class PurchaseProposalApproveDialogWidget extends StatelessWidget {
  final String title;
  final int proposalId;
  final String action;
  final String type;
  const PurchaseProposalApproveDialogWidget(
      {Key? key,
      required this.title,
      required this.proposalId,
      required this.action,
      required this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController descEditingController = TextEditingController();
    ProposalApproveRequest request =
        new ProposalApproveRequest(this.proposalId, this.action, '');
    return AlertDialog(
        insetPadding: EdgeInsets.all(0),
        title: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(defaultPadding / 2),
            color: HexColor('#5DB9D8'),
            child: Text(
              'Xác nhận ' + title,
              style: TextStyle(color: Colors.white),
            )),
        titlePadding: EdgeInsets.zero,
        content: Container(
            width: 300,
            height: 260,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tác vụ:',
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: defaultPadding),
                    child: TextFormField(
                      enabled: false,
                      initialValue: title,
                      decoration: InputDecoration(
                          fillColor: HexColor('#F2F2F2'), filled: true),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding),
                      child: Text(
                        'Lời nhắn:',
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: defaultPadding),
                    child: TextFormField(
                      minLines: 3,
                      maxLines: 5,
                      style: TextStyle(decoration: TextDecoration.none),
                      controller: descEditingController,
                      decoration: InputDecoration(
                          hintText: 'Nhập lời nhắn',
                          fillColor: HexColor('#EAF8FE'),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          filled: true),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              color: HexColor('#3498B7'),
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding,
                                  vertical: defaultPadding / 2),
                              onPressed: () {
                                request.messages =
                                    descEditingController.value.text;
                                switch (this.type) {
                                  // case ModuleTypeCheck
                                  //     .purchaseorder: // đơn mua hàng
                                  //   Get.find<OrderController>()
                                  //       .approveOrder(request)
                                  //       .then((value) {
                                  //     if (value) {
                                  //       Get.find<
                                  //               FilterPurchaseOrderController>()
                                  //           .filter(Get.find<
                                  //                   FilterPurchaseOrderController>()
                                  //               .filterResult);
                                  //       FunctionHelper.showSnackbar(
                                  //           'Thông báo',
                                  //           '${this.title} thành công',
                                  //           StatusMessage.success);
                                  //     }
                                  //   });
                                  //   Get.back();
                                  //   break;
                                  case ModuleTypeCheck
                                      .purchaseproposal: // đề nghị mua hàng
                                    Get.find<ProposalController>()
                                        .approveProposal(request)
                                        .then((value) {
                                      if (value) {
                                        Get.find<FilterProposalController>()
                                            .filter(Get.find<
                                                    FilterProposalController>()
                                                .filterProposalResult);
                                        FunctionHelper.showSnackbar(
                                            'Thông báo',
                                            '${this.title} thành công',
                                            StatusMessage.success);
                                      }
                                    });
                                    Get.back();
                                    break;
                                  // case ModuleTypeCheck
                                  //     .paymentproposal: // đề nghị thanh toán
                                  //   Get.find<PaymentProposalController>()
                                  //       .approveProposal(request)
                                  //       .then((value) {
                                  //     if (value) {
                                  //       Get.find<
                                  //               PaymentProposalListController>()
                                  //           .filter(Get.find<
                                  //                   PaymentProposalListController>()
                                  //               .filterResult);
                                  //       FunctionHelper.showSnackbar(
                                  //           'Thông báo',
                                  //           '${this.title} thành công',
                                  //           StatusMessage.success);
                                  //     }
                                  //   });
                                  //   Get.back();
                                  //   break;
                                  default:
                                    Get.back();
                                    break;
                                }
                              },
                              child: Text(
                                "Đồng ý",
                                // style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              color: Colors.black.withOpacity(0.5),
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding,
                                  vertical: defaultPadding / 2),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Hủy",
                                // style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            )));
  }
}
