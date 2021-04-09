import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_item.model.dart';
import 'package:flutter_demo_getx/pages/proposal/controllers/proposal_controller.dart';
import 'package:flutter_demo_getx/pages/shares/inventory_detail_dialog.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';
import 'package:flutter_demo_getx/utils/function_helper.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';
import '../../../../../utils/date_time_extension.dart';

class PurchaseProposalMechandiseListWidget extends StatelessWidget {
  final List<ProposalItemModel> items;
  const PurchaseProposalMechandiseListWidget({Key? key, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        margin: EdgeInsets.only(top: defaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Danh sách hàng hóa:',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(top: defaultPadding / 2),
                    decoration: BoxDecoration(
                        color:
                            index % 2 == 0 ? HexColor('#F7FCFF') : Colors.white,
                        border: Border.all(color: HexColor('#F2F2F2'))),
                    child: IntrinsicHeight(
                      child: Row(children: [
                        Expanded(
                            flex: 7,
                            child: Container(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Get.find<ProposalController>()
                                                .getProductInventory(
                                                    items[index].product!.id!);
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    InventoryDetailDialog());
                                          },
                                          child: Text(
                                              '${items[index].product?.no} - ${items[index].product?.name}',
                                              style: TextStyle(
                                                  color: HexColor('#027DB4'),
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Text(
                                          '${items[index].neededFromDate?.formatDateDefault()} - ${items[index].neededToDate?.formatDateDefault()}'),
                                      if (items[index].comment != null &&
                                          items[index].comment!.isNotEmpty)
                                        Text(items[index].comment!)
                                    ]))),
                        Expanded(
                            flex: 3,
                            child: Column(children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: HexColor('#f7f1e6'),
                                      border: Border(
                                          left: BorderSide(
                                              color: HexColor('#F2F2F2')),
                                          bottom: BorderSide(
                                              color: HexColor('#F2F2F2')))),
                                  child: Text(
                                      FunctionHelper.formatCurrencyNumber(
                                          items[index].quantity!,
                                          decimalDigits: 2),
                                      style: CustomTheme.bodyText(context)
                                          .apply(color: HexColor('#F59A23')))),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: HexColor('#F2F2F2')))),
                                    child: Text(
                                        items[index].measureUnit?.name ?? '')),
                              )
                            ]))
                      ]),
                    ));
              })
        ]));
  }
}
