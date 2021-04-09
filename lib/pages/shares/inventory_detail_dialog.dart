import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/pages/proposal/controllers/proposal_controller.dart';
import 'package:flutter_demo_getx/utils/function_helper.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';

class InventoryDetailDialog extends StatelessWidget {
  const InventoryDetailDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(defaultPadding / 2),
          color: HexColor('#5DB9D8'),
          child: Text(
            'Chi tiết tồn kho',
            style: TextStyle(color: Colors.white),
          )),
      titlePadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: 300,
          // height: 325,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child:
                  GetBuilder<ProposalController>(builder: (proposalController) {
                if (proposalController.isLoadingInventoryDetail)
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()]);
                else
                  return Column(
                    children: [
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(5),
                          1: FlexColumnWidth(3)
                        },
                        border: TableBorder.all(color: HexColor('#F2F2F2')),
                        children: [
                          TableRow(children: [
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text('Số lượng hiện có')),
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text(
                                  FunctionHelper.formatCurrencyNumber(
                                      proposalController
                                              .productInventory.onHandQty ??
                                          0,
                                      decimalDigits: 4),
                                  textAlign: TextAlign.end,
                                ))
                          ]),
                          TableRow(children: [
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text('Số lượng đặt bán')),
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text(
                                  FunctionHelper.formatCurrencyNumber(
                                      proposalController
                                              .productInventory.saleOrderQty ??
                                          0,
                                      decimalDigits: 4),
                                  textAlign: TextAlign.end,
                                ))
                          ]),
                          TableRow(children: [
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text('Số lượng có thể sử dụng')),
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text(
                                  FunctionHelper.formatCurrencyNumber(
                                      proposalController
                                              .productInventory.availableQty ??
                                          0,
                                      decimalDigits: 4),
                                  textAlign: TextAlign.end,
                                ))
                          ]),
                          TableRow(children: [
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text('Số lượng đặt mua')),
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text(
                                  FunctionHelper.formatCurrencyNumber(
                                      proposalController.productInventory
                                              .purchaseOrderQty ??
                                          0,
                                      decimalDigits: 4),
                                  textAlign: TextAlign.end,
                                ))
                          ]),
                          TableRow(children: [
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text('Số lượng hàng về')),
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text(
                                  FunctionHelper.formatCurrencyNumber(
                                      proposalController
                                              .productInventory.transitOutQty ??
                                          0,
                                      decimalDigits: 4),
                                  textAlign: TextAlign.end,
                                ))
                          ]),
                          TableRow(children: [
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text('Số lượng trung chuyển')),
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text(
                                  FunctionHelper.formatCurrencyNumber(
                                      proposalController
                                              .productInventory.transitInQty ??
                                          0,
                                      decimalDigits: 4),
                                  textAlign: TextAlign.end,
                                ))
                          ]),
                          TableRow(children: [
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text('Số lượng hoạch định sử dụng')),
                            Padding(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Text(
                                  FunctionHelper.formatCurrencyNumber(
                                      proposalController.productInventory
                                              .allocationPlan ??
                                          0,
                                      decimalDigits: 4),
                                  textAlign: TextAlign.end,
                                ))
                          ])
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: defaultPadding),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            color: Colors.black.withOpacity(0.5),
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                                vertical: defaultPadding / 2,
                                horizontal: defaultPadding),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Đóng",
                            ),
                          ))
                    ],
                  );
              })),
            ],
          ),
        ),
      ),
    );
  }
}
