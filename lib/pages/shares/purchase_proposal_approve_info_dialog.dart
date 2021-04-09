import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/pages/proposal/controllers/proposal_controller.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';
import '../../utils/date_time_extension.dart';

class PurchaseProposalApproveInfoDialogWidget extends StatelessWidget {
  const PurchaseProposalApproveInfoDialogWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(defaultPadding / 2),
            color: HexColor('#5DB9D8'),
            child: Text(
              'Thông tin xét duyệt',
              style: TextStyle(color: Colors.white),
            )),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: Container(
            width: double.maxFinite,
            height: 360,
            child:
                GetBuilder<ProposalController>(builder: (proposalController) {
              if (proposalController.isLoadingApproveList)
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()]);
              else if (proposalController.approveHistoryList?.length != 0)
                return Column(children: [
                  Container(
                    height: 300,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            proposalController.approveHistoryList?.length,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.all(defaultPadding / 2),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: HexColor('#F2F2F2')))),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text(
                                          proposalController
                                                  .approveHistoryList![index]
                                                  .action
                                                  ?.displayText ??
                                              '',
                                          style: TextStyle(
                                              color: HexColor('#027DB4'),
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                          child: Text(
                                              proposalController
                                                  .approveHistoryList![index]
                                                  .approvalDate!
                                                  .formatDateTimeString(),
                                              textAlign: TextAlign.end))
                                    ]),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: defaultPadding / 2,
                                            left: defaultPadding),
                                        child: Text('Người duyệt: ' +
                                            proposalController
                                                .approveHistoryList![index]
                                                .employee!
                                                .name!)),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: defaultPadding / 2,
                                            left: defaultPadding),
                                        child: Text('Lời nhắn: ' +
                                            proposalController
                                                .approveHistoryList![index]
                                                .messages!))
                                  ]));
                        }),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: defaultPadding / 2,
                            horizontal: defaultPadding),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Đóng"),
                      ))
                ]);
              else
                return Column(children: [
                  Container(
                      alignment: Alignment.center,
                      height: 300,
                      child: Text('Không có dữ liệu')),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: defaultPadding / 2,
                            horizontal: defaultPadding),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Đóng"),
                      ))
                ]);
            })));
  }
}
