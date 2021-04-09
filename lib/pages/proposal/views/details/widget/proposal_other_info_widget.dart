import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/approve_status.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_info.model.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';

class PurchaseProposalOtherInfoWidget extends StatelessWidget {
  final ProposalInfoModel? proposal;
  const PurchaseProposalOtherInfoWidget({Key? key, this.proposal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(defaultPadding / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(defaultPadding / 2)),
                    color: proposal?.approveStatus?.code ==
                            ApproveStatus.Approved.toShortString()
                        ? Colors.green
                        : proposal?.approveStatus?.code ==
                                ApproveStatus.NeedApprove.toShortString()
                            ? Colors.orange
                            : proposal?.approveStatus?.code ==
                                    ApproveStatus.RejectionApproved
                                        .toShortString()
                                ? Colors.red
                                : Colors.blue,
                  ),
                  child: Text(
                    proposal?.approveStatus?.displayText ?? '',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            'Nhân viên thực hiện:',
                            style: TextStyle(color: HexColor('#555555')),
                          ))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(top: defaultPadding / 2),
                            padding: EdgeInsets.all(defaultPadding / 2),
                            color: HexColor('#EAF8FE'),
                            child: Text(proposal?.createdEmployee?.name ?? ''),
                          ))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('Phòng ban:',
                                  style:
                                      TextStyle(color: HexColor('#555555')))),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Expanded(
                              flex: 1,
                              child: Text('Bộ phận:',
                                  style:
                                      TextStyle(color: HexColor('#555555')))),
                        ],
                      )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(top: defaultPadding / 2),
                            padding: EdgeInsets.all(defaultPadding / 2),
                            color: HexColor('#EAF8FE'),
                            child: Text(proposal?.department?.name ?? ''),
                          )),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(top: defaultPadding / 2),
                            padding: EdgeInsets.all(defaultPadding / 2),
                            color: HexColor('#EAF8FE'),
                            child: Text(proposal?.departmentRoom?.name ?? ''),
                          )),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('Diễn giải:',
                                  style: TextStyle(color: HexColor('#555555'))))
                        ],
                      )),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            // height: 100,
                            margin: EdgeInsets.only(top: defaultPadding / 2),
                            padding: EdgeInsets.all(defaultPadding / 2),
                            color: HexColor('#EAF8FE'),
                            child: Text(proposal?.desc ?? ''),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
