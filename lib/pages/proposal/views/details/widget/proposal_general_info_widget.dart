import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/approve_status.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_info.model.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import '../../../../../utils/date_time_extension.dart';

class PurchaseProposalGeneralInfoWidget extends StatelessWidget {
  final ProposalInfoModel? proposal;
  const PurchaseProposalGeneralInfoWidget({Key? key, this.proposal})
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
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            Container(
              padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding * 2.5,
                  defaultPadding, defaultPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            'Mã chứng từ:',
                            style: TextStyle(color: HexColor('#555555')),
                          )),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      Expanded(
                          flex: 1,
                          child: Text('Ngày chứng từ:',
                              style: TextStyle(color: HexColor('#555555')))),
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
                            child: Text(proposal?.no ?? ''),
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
                            child:
                                Text(proposal?.date?.formatDateDefault() ?? ''),
                          )),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('Chi nhánh:',
                                  style:
                                      TextStyle(color: HexColor('#555555')))),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Expanded(
                              flex: 1,
                              child: Text('Người đề nghị:',
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
                            child: Text(proposal?.branch?.name ?? ''),
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
                            child: Text(proposal?.proposedEmployee?.name ?? ''),
                          )),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('Loại đề nghị:',
                                  style:
                                      TextStyle(color: HexColor('#555555')))),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Expanded(
                              flex: 1,
                              child: Text('Loại hàng hóa:',
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
                            child: Text(proposal?.type?.displayText ?? ''),
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
                            child: Text(
                                proposal?.commodityType?.displayText ?? ''),
                          )),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('Từ ngày:',
                                  style:
                                      TextStyle(color: HexColor('#555555')))),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Expanded(
                              flex: 1,
                              child: Text('Đến ngày:',
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
                            child: Text(
                                proposal?.neededFromDate?.formatDateDefault() ??
                                    ''),
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
                            child: Text(
                                proposal?.neededToDate?.formatDateDefault() ??
                                    ''),
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
