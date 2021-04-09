import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/constants/module_name.dart';
import 'package:flutter_demo_getx/routes/app_pages.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';

const Color defaultTextColor = Color(4283903388);
const Color defaultBgColor = Color(4284594646);
const Color defaultTextGray = Color(4286085240);
const Color defaultBgScreen = Color(4294047738);
const double defaultPadding = 16;
const double defaultFontSize = 13.0;
const double defaultTextPosisionSize = 11.0;
const LinearGradient defaultGradient =
    LinearGradient(colors: [Color(4283117212), Color(4294910627)]);
const BoxShadow defaultBoxShadow = BoxShadow(
    offset: Offset(0, defaultPadding / 2),
    blurRadius: defaultPadding / 2,
    color: Colors.black12);

final List<DictionaryItem?> menuItem = [
  // DictionaryItem(
  //     value: '1',
  //     displayText: 'Thông tin kinh doanh',
  //     code: Routes.businessInformation,
  //     key: ModuleName.businessInformation,
  //     typeGroup: '0'),
  // DictionaryItem(
  //     value: '2',
  //     displayText: 'Thông tin sản xuất',
  //     code: Routes.manufacturingInformation,
  //     key: ModuleName.manufacturingInformation,
  //     typeGroup: '0'),
  // DictionaryItem(
  //     value: '3',
  //     displayText: 'Thông tin lợi nhuận',
  //     code: Routes.profitInformation,
  //     key: ModuleName.profitInformation,
  //     typeGroup: '0'),
  DictionaryItem(value: '4', displayText: 'Duyệt chứng từ', typeGroup: '0'),
  DictionaryItem(
      value: '5',
      displayText: 'Đề nghị mua hàng',
      code: Routes.purchaseProposal,
      key: ModuleName.purchaseProposal,
      typeGroup: '4'),
  // DictionaryItem(
  //     value: '6',
  //     displayText: 'Đơn mua hàng',
  //     code: Routes.purchaseOrder,
  //     key: ModuleName.purchaseOrder,
  //     typeGroup: '4'),
  // DictionaryItem(
  //     value: '7',
  //     displayText: 'Đề nghị thanh toán',
  //     code: Routes.paymentProposal,
  //     key: ModuleName.paymentProposal,
  //     typeGroup: '4'),
];
