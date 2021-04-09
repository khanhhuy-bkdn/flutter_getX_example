import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/approve_status.dart';
import 'package:flutter_demo_getx/routes/app_pages.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/models/proposal/filter_proposal_model.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_model.dart';
import 'package:flutter_demo_getx/pages/menu/views/menu.dart';
import 'package:flutter_demo_getx/pages/proposal/controllers/filter_proposal_controller.dart';
import 'package:flutter_demo_getx/pages/proposal/views/filter_view.dart';
import 'package:flutter_demo_getx/pages/shares/button_filter_approve.dart';
import 'package:flutter_demo_getx/pages/shares/loading_circular_process.dart';
import 'package:flutter_demo_getx/pages/shares/marquee_widget.dart';
import 'package:flutter_demo_getx/pages/shares/no_data.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';
import '../../../utils/date_time_extension.dart';

class ProposalView extends StatefulWidget {
  static final String routerName = '/proposal';
  @override
  _ProposalViewState createState() => _ProposalViewState();
}

class _ProposalViewState extends State<ProposalView>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  ScrollController _scrollController = ScrollController();
  FilterProposalController? _filterProposalController;
  //position
  List<bool> _selections = List.generate(4, (index) => false);
  List<DictionaryItem> listButton = [
    new DictionaryItem(
        value: ApproveStatus.NeedApprove.toShortString(),
        displayText: 'Chưa duyệt'),
    new DictionaryItem(
        value: ApproveStatus.Recheck.toShortString(),
        displayText: 'Cần kiểm tra'),
    new DictionaryItem(
        value: ApproveStatus.RejectionApproved.toShortString(),
        displayText: 'Từ chối'),
    new DictionaryItem(
        value: ApproveStatus.Approved.toShortString(), displayText: 'Đã duyệt'),
  ];

  FilterProposalModel filterProposal = new FilterProposalModel(
      page: 0,
      pageSize: 20,
      toDate: DateTime.now(),
      fromDate: new DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 7));
  var defaultFontSize = 13.0;
  var defaultTextPosisionSize = 11.0;

  int _buttonChoose = 0;

  @override
  void initState() {
    super.initState();
    _filterProposalController = Get.find<FilterProposalController>();
    _filterProposalController!.filter(filterProposal);
    var data = _filterProposalController!.filterProposalResult;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        data = _filterProposalController!.filterProposalResult;
        if (_buttonChoose > 0) {
          data!.approvedStatus = listButton[_buttonChoose - 1];
        }
        _filterProposalController!.filter(data!.copyWith(page: data!.page + 1));
      }
    });
  }

  Future<void> _pullRefresh() async {
    var data = _filterProposalController!.filterProposalResult;
    if (_buttonChoose > 0) {
      data!.approvedStatus = listButton[_buttonChoose - 1];
    }
    _filterProposalController!.filter(data?.copyWith(page: 0) ?? null);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      drawerEnableOpenDragGesture: false,
      drawer: Menu(),
      endDrawer: Filter(),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Column(
                  children: <Widget>[
                    headerWidget(context),
                    Expanded(child: itemWidget(context)),
                  ],
                ),
              ),
              positionWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: defaultBgColor,
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              Expanded(
                child: Text(
                  "DANH SÁCH ĐỀ NGHỊ MUA HÀNG",
                  textAlign: TextAlign.center,
                  style: CustomTheme.headline6(context),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.filter_alt_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: GetBuilder<FilterProposalController>(
                init: _filterProposalController,
                builder: (item) {
                  return Text(
                    '${item.filterProposalResult?.fromDate?.formatDateDefault() ?? ''} - ${item.filterProposalResult?.toDate?.formatDateDefault() ?? ''}',
                    textAlign: TextAlign.center,
                    style: CustomTheme.subTitle2(context)
                        .apply(color: Colors.white),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget itemWidget(BuildContext context) {
    return Container(
        color: HexColor('#f1f7fa'),
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),
          child: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: GetBuilder<FilterProposalController>(
              init: _filterProposalController,
              builder: (item) {
                if (item.filterProposalResult?.approvedStatus == null) {
                  _buttonChoose = 0;
                  _selections = List.generate(4, (index) => false);
                }
                if (item.isLoading) {
                  return LoadingCircularProcess();
                }
                if (item.listResult != null && item.listResult!.length > 0) {
                  return CustomScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      controller: _scrollController,
                      slivers: [
                        SliverPadding(
                            padding: EdgeInsets.all(0),
                            sliver: SliverList(
                                delegate: SliverChildListDelegate(
                                    _buildList(item.listResult!)))),
                        SliverToBoxAdapter(
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                alignment: Alignment.center,
                                child: item.canLoadMore
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2))
                                    : null))
                      ]);
                } else {
                  return NoData();
                }
              },
            ),
          ),
        ));
  }

  Widget positionWidget(BuildContext context) {
    return Positioned(
        top: 70.0,
        left: 0.0,
        right: 0.0,
        child: GetBuilder<FilterProposalController>(
            init: _filterProposalController,
            builder: (item) {
              if (item.filterProposalResult?.approvedStatus == null) {
                _selections = List.generate(4, (index) => false);
                _buttonChoose = 0;
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ToggleButtons(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      constraints: BoxConstraints.expand(
                          width: (constraints.maxWidth - 5) / 4),
                      children: <Widget>[
                        ButtonFilterApprove(
                            numberString:
                                (item.proposalResult?.requiredQty ?? 0)
                                    .toString(),
                            textButton: 'Chưa duyệt',
                            color: Colors.orange),
                        ButtonFilterApprove(
                            numberString: (item.proposalResult?.recheckQty ?? 0)
                                .toString(),
                            textButton: 'Cần kiểm tra lại',
                            color: Colors.blue),
                        ButtonFilterApprove(
                            numberString:
                                (item.proposalResult?.rejectionQty ?? 0)
                                    .toString(),
                            textButton: 'Từ chối',
                            color: Colors.red),
                        ButtonFilterApprove(
                            numberString:
                                (item.proposalResult?.approvedQty ?? 0)
                                    .toString(),
                            textButton: 'Đã duyệt',
                            color: Colors.green),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < _selections.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              _selections[buttonIndex] = true;
                              _buttonChoose = index + 1;
                              item.filterProposalResult!.approvedStatus =
                                  listButton[buttonIndex];
                              item.filterProposalResult?.page = 0;
                              _filterProposalController!
                                  .filter(item.filterProposalResult);
                            } else {
                              _selections[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: _selections,
                    );
                  },
                ),
              );
            }));
  }

  List<Widget> _buildList(List<ProposalModel?> list) {
    List<Widget> listItems = [];
    for (int index = 0; index < list.length; index++) {
      listItems.add(
        ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          child: InkWell(
            onTap: () {
              Get.toNamed(
                  Routes.purchaseProposal + Routes.purchaseProposalDetail,
                  arguments: list[index]?.id);
            },
            child: Container(
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: list[index]?.approveStatus?.code ==
                                  ApproveStatus.Approved.toShortString()
                              ? Colors.green
                              : list[index]?.approveStatus?.code ==
                                      ApproveStatus.NeedApprove.toShortString()
                                  ? Colors.orange
                                  : list[index]?.approveStatus?.code ==
                                          ApproveStatus.RejectionApproved
                                              .toShortString()
                                      ? Colors.red
                                      : Colors.blue,
                          width: 3)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Mã chứng từ ',
                        style: CustomTheme.bodyText1(context).apply(
                          color: HexColor('#3a9ac5'),
                        ),
                      ),
                      SelectableText(
                        '${list[index]?.no ?? ''}',
                        style: CustomTheme.subTitle1(context).apply(
                          color: HexColor('#3a9ac5'),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          list[index]?.date?.formatDateDefault() ?? '',
                          textAlign: TextAlign.right,
                          style: CustomTheme.bodyText1(context).apply(
                            color: HexColor('#3a9ac5'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Loại đề nghị: ${list[index]?.type?.displayText ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        style: CustomTheme.bodyText2(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Loại hàng hóa: ${list[index]?.commodityType?.displayText ?? ''}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTheme.bodyText2(context),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: MarqueeWidget(
                            direction: Axis.horizontal,
                            child: Text(
                              "${list[index]?.createdEmployee?.name ?? ''}",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: CustomTheme.bodyText2(context)
                                  .apply(color: Colors.brown[400]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return listItems;
  }
}
