import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/config_key_group.dart';
import 'package:flutter_demo_getx/models/branch.model.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/models/employee/employee_model.dart';
import 'package:flutter_demo_getx/models/employee/filter_employee_request.dart';
import 'package:flutter_demo_getx/models/proposal/filter_proposal_model.dart';
import 'package:flutter_demo_getx/pages/proposal/controllers/filter_proposal_controller.dart';
import 'package:flutter_demo_getx/pages/shares/dropdown_search.dart';
import 'package:flutter_demo_getx/pages/shares/text_field_choose_custom.dart';
import 'package:flutter_demo_getx/services/repository/infrastructure/master_data/master_data_repository.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';
import '../../../utils/date_time_extension.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  FilterProposalModel? _filterProposal;
  List<DictionaryItem> commodityTypeList = [];
  List<DictionaryItem> employeeList = [];
  List<DictionaryItem> typeList = [];
  MasterDataRepository _service =
      new MasterDataRepository(apiProvider: Get.find());

  TextEditingController noController = TextEditingController();
  FilterProposalController _controller = Get.find<FilterProposalController>();
  final FocusNode _noFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    FilterProposalModel _filter =
        Get.find<FilterProposalController>().filterProposalResult!;

    _filterProposal = _filter.copy();

    noController =
        TextEditingController(text: this._filterProposal?.searchKey ?? '');
  }

  Future<List<DictionaryItem>> getTypeList() async {
    return await _service.getByConfigGroup(ConfigKeyGroup.purchaseProposalType);
  }

  Future<List<DictionaryItem>> getCommodityTypeList() async {
    return await _service.getByConfigGroup(ConfigKeyGroup.commodityType);
  }

  Future<List<DictionaryItem>> getProposalAPTypeList() async {
    return await _service.getByConfigGroup(ConfigKeyGroup.proposalAPType);
  }

  Future<List<EmployeeModel>> getListEmployee(String query, num? page) async {
    return await _service.getListEmployee(
        FilterEmployeeRequest(page: page ?? 0, pageSize: 20, searchKey: query));
  }

  Future<List<BranchModel>> getListBranch() async {
    return await _service.getBranchs();
  }

  void deleteFilter() {
    noController = TextEditingController(text: '');
    _filterProposal = FilterProposalModel(page: 0, pageSize: 20);
    _controller.filter(_filterProposal);
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: HexColor('f1f7fa')),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: defaultBgColor,
                      ),
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: CustomTheme.bodyText2(context).fontSize,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Align(
                              child: Text(
                                'Bộ lọc',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      CustomTheme.bodyText2(context).fontSize! +
                                          7,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Text('Từ ngày:'),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: TextFieldChooseCustom(
                                  title: '--Chọn--',
                                  data: this._filterProposal?.fromDate != null
                                      ? this
                                          ._filterProposal
                                          ?.fromDate
                                          ?.formatDateDefault()
                                      : '',
                                  iconRight: Icons.date_range,
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        minDateTime: DateTime(1995, 1, 1),
                                        maxDateTime: DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day),
                                        onChange: (date, list) {},
                                        onConfirm: (date, list) {
                                      this._filterProposal?.fromDate = date;

                                      setState(() {});
                                    },
                                        initialDateTime:
                                            this._filterProposal?.fromDate,
                                        locale: DateTimePickerLocale.vi,
                                        pickerTheme: DateTimePickerTheme(
                                            confirmTextStyle:
                                                TextStyle(color: Colors.blue)),
                                        dateFormat: 'dd-MMMM-yyyy');
                                  },
                                ),
                              )
                            ],
                          )),
                          Flexible(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Text('Đến ngày:'),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: TextFieldChooseCustom(
                                  title: '--Chọn--',
                                  data: this._filterProposal?.toDate != null
                                      ? this
                                          ._filterProposal
                                          ?.toDate
                                          ?.formatDateDefault()
                                      : '',
                                  iconRight: Icons.date_range,
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        minDateTime: DateTime(1995, 1, 1),
                                        maxDateTime: DateTime(
                                            DateTime.now().year,
                                            DateTime.now()
                                                .add(new Duration(days: 31))
                                                .month,
                                            DateTime.now().day),
                                        onChange: (date, list) {},
                                        onConfirm: (date, list) {
                                      this._filterProposal?.toDate = date;

                                      setState(() {});
                                    },
                                        initialDateTime:
                                            this._filterProposal?.toDate,
                                        locale: DateTimePickerLocale.vi,
                                        pickerTheme: DateTimePickerTheme(
                                            confirmTextStyle:
                                                TextStyle(color: Colors.blue)),
                                        dateFormat: 'dd-MMMM-yyyy');
                                  },
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15, left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text('Chi nhánh:'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(top: 5),
                            child: DropdownSearch<BranchModel>(
                              isFilter: true,
                              isLoadmore: false,
                              mode: Mode.BOTTOM_SHEET,
                              hint: '--Tất cả--',
                              onFind: (String filter, [num? page]) =>
                                  getListBranch(),
                              compareFn: (BranchModel i, BranchModel? s) =>
                                  i.id == s?.id,
                              onChanged: (value) => setState(() {
                                _filterProposal?.branch = value;
                              }),
                              selectedItem: _filterProposal?.branch,
                              showSelectedItem: true,
                              showSearchBox: true,
                              searchBoxDecoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 8, 0),
                                labelText: "Tìm kiếm",
                              ),
                              labelPopupTitle: 'Chi nhánh',
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text('Từ khóa:'),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 5),
                              height: 30,
                              child: TextFormField(
                                controller: noController,
                                focusNode: _noFocus,
                                textInputAction: TextInputAction.done,
                                decoration: new InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: HexColor('#b2b2b2'),
                                            width: 0.5)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: HexColor('#b5e3f2'))),
                                    hintText: 'Mã chứng từ',
                                    fillColor: Colors.white,
                                    filled: true),
                                onFieldSubmitted: (String data) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text('Nhân viên thực hiện:'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(top: 5),
                            child: DropdownSearch<EmployeeModel>(
                              isFilter: true,
                              mode: Mode.BOTTOM_SHEET,
                              hint: '--Tất cả--',
                              compareFn: (EmployeeModel i, EmployeeModel? s) =>
                                  i.id == s?.id,
                              onFind: (String filter, [num? page]) =>
                                  getListEmployee(filter, page),
                              onChanged: (value) => setState(() {
                                _filterProposal?.employee = value;
                              }),
                              isFilteredOnline: true,
                              selectedItem: _filterProposal?.employee,
                              showSelectedItem: true,
                              showSearchBox: true,
                              searchBoxDecoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 8, 0),
                                labelText: "Tìm kiếm",
                              ),
                              labelPopupTitle: 'Nhân viên',
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text('Loại đề nghị:'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(top: 5),
                            child: DropdownSearch<DictionaryItem>(
                              isFilter: true,
                              isLoadmore: false,
                              mode: Mode.BOTTOM_SHEET,
                              hint: '--Tất cả--',
                              onFind: (String filter, [num? page]) =>
                                  getTypeList(),
                              compareFn:
                                  (DictionaryItem i, DictionaryItem? s) =>
                                      i.code == s?.code,
                              onChanged: (value) => setState(() {
                                _filterProposal?.type = value;
                              }),
                              selectedItem: _filterProposal?.type,
                              showSelectedItem: true,
                              showSearchBox: true,
                              searchBoxDecoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 8, 0),
                                labelText: "Tìm kiếm",
                              ),
                              labelPopupTitle: 'Loại đề nghị',
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text('Loại hàng hóa:'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(top: 5),
                            child: DropdownSearch<DictionaryItem>(
                              isFilter: true,
                              isLoadmore: false,
                              mode: Mode.BOTTOM_SHEET,
                              hint: '--Tất cả--',
                              onFind: (String filter, [num? page]) =>
                                  getProposalAPTypeList(),
                              compareFn:
                                  (DictionaryItem i, DictionaryItem? s) =>
                                      i.code == s?.code,
                              onChanged: (value) => setState(() {
                                _filterProposal?.commodityType = value;
                              }),
                              selectedItem: _filterProposal?.commodityType,
                              showSelectedItem: true,
                              showSearchBox: true,
                              searchBoxDecoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 8, 0),
                                labelText: "Tìm kiếm",
                              ),
                              labelPopupTitle: 'Loại hàng hóa',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: ButtonTheme(
                          child: FlatButton(
                            color: defaultBgColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              Get.back();
                              this._filterProposal?.approvedStatus = null;
                              this._filterProposal?.page = 0;
                              _filterProposal?.searchKey = noController.text;
                              Get.find<FilterProposalController>()
                                  .filter(_filterProposal);
                            },
                            textColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                'Lọc',
                                style: CustomTheme.bodyText1(context)
                                    .apply(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 10),
                        child: ButtonTheme(
                          child: FlatButton(
                            color: HexColor("#aaabab"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              deleteFilter();
                            },
                            textColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                'Xóa lọc',
                                style: CustomTheme.bodyText1(context)
                                    .apply(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
