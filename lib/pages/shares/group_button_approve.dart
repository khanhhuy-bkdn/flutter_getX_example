import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/approve_status.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/pages/proposal/controllers/proposal_controller.dart';
import 'package:flutter_demo_getx/pages/shares/purchase_proposal_approve_dialog.dart';
import 'package:flutter_demo_getx/pages/shares/purchase_proposal_approve_info_dialog.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';

class GroupButtonApproveWidget extends StatelessWidget {
  final DictionaryItem? approveStatus;
  final isShowApprovalDetail;
  final String? type;
  final int? objectId;
  const GroupButtonApproveWidget(
      {Key? key,
      this.approveStatus,
      this.isShowApprovalDetail,
      this.type,
      this.objectId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (approveStatus?.code == ApproveStatus.NeedApprove.toShortString() &&
        isShowApprovalDetail == true)
      return Container(
        margin: EdgeInsets.only(top: defaultPadding / 2),
        child: Column(
          children: [
            FlatButton(
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: Colors.white,
              textColor: HexColor('#00AEF2'),
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              onPressed: () {
                Get.find<ProposalController>()
                    .getApproveHistoryList(objectId!, type!);
                showDialog(
                    context: context,
                    builder: (_) => PurchaseProposalApproveInfoDialogWidget());
              },
              child: Text(
                "Xem thông tin xét duyệt",
                // style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding / 2),
              child: FlatButton(
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: HexColor('#F59A23'),
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => PurchaseProposalApproveDialogWidget(
                            title: 'Duyệt',
                            proposalId: objectId!,
                            action: 'Approve',
                            type: type!,
                          ));
                },
                child: Text(
                  "Duyệt",
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: HexColor('#3498B7'),
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                          vertical: defaultPadding / 2),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => PurchaseProposalApproveDialogWidget(
                                  title: 'Kiểm tra lại',
                                  proposalId: objectId!,
                                  action: 'Recheck',
                                  type: type!,
                                ));
                      },
                      child: Text(
                        "Kiểm tra lại",
                        // style: TextStyle(fontSize: 20.0),
                      ),
                    )),
                SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: HexColor('#AAAAAA'),
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                          vertical: defaultPadding / 2),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => PurchaseProposalApproveDialogWidget(
                                  title: 'Từ chối',
                                  proposalId: objectId!,
                                  action: 'Refuse',
                                  type: type!,
                                ));
                      },
                      child: Text(
                        "Từ chối",
                        // style: TextStyle(fontSize: 20.0),
                      ),
                    )),
              ],
            )
          ],
        ),
      );
    else if (approveStatus?.code == ApproveStatus.NeedApprove.toShortString())
      return Container(
        margin: EdgeInsets.only(top: defaultPadding / 2),
        child: Column(
          children: [
            FlatButton(
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: HexColor('#F59A23'),
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => PurchaseProposalApproveDialogWidget(
                          title: 'Duyệt',
                          proposalId: objectId!,
                          action: 'Approve',
                          type: type!,
                        ));
              },
              child: Text(
                "Duyệt",
              ),
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: HexColor('#3498B7'),
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                          vertical: defaultPadding / 2),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => PurchaseProposalApproveDialogWidget(
                                  title: 'Kiểm tra lại',
                                  proposalId: objectId!,
                                  action: 'Recheck',
                                  type: type!,
                                ));
                      },
                      child: Text(
                        "Kiểm tra lại",
                        // style: TextStyle(fontSize: 20.0),
                      ),
                    )),
                SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: HexColor('#AAAAAA'),
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                          vertical: defaultPadding / 2),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => PurchaseProposalApproveDialogWidget(
                                  title: 'Từ chối',
                                  proposalId: objectId!,
                                  action: 'Refuse',
                                  type: type!,
                                ));
                      },
                      child: Text(
                        "Từ chối",
                        // style: TextStyle(fontSize: 20.0),
                      ),
                    )),
              ],
            )
          ],
        ),
      );
    else
      return Container(
          margin: EdgeInsets.only(top: defaultPadding / 2),
          child: Column(children: [
            FlatButton(
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: Colors.white,
              textColor: HexColor('#00AEF2'),
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              onPressed: () {
                Get.find<ProposalController>()
                    .getApproveHistoryList(objectId!, type!);
                showDialog(
                    context: context,
                    builder: (_) => PurchaseProposalApproveInfoDialogWidget());
              },
              child: Text("Xem thông tin xét duyệt"),
            )
          ]));
  }
}
