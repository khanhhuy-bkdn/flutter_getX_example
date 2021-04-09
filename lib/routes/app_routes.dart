part of 'app_pages.dart';

abstract class Routes {
  //---------------------------------------------------
  static String login = '/login';
  static String purchaseOrder = '/saleorder';
  static String purchaseProposal = '/proposal';
  static String paymentProposal = '/payment_proposal'; // Đề nghị thanh toán
  static String profitInformation =
      '/profit_information'; // Thông tin lợi nhuận
  static String payment = '/payment';
  static String businessInformation =
      '/business_information'; //Thông tin kinh doanh
  static String businessInformationDetail = '/business_information_detail';
  static String profitInformationDetail = '/profit_information_detail';
  static String productionInformationDetail = '/production_information_detail';
  static String paymentProposalDetail = '/payment_proposal_detail';
  static String paymentProposalInvoiceDetail =
      '/payment_proposal_inoice_detail';
  static String purchaseOrderDetail = '/purchase-order-detail';
  static String purchaseProposalDetail = '/purchase-proposal-detail';
  static String overdueInformationDetail = '/overdue_information_detail';
  static String paymentProposalCashFundList =
      '/payment_proposal_cash_fund_list';
  static String businessInformationChart = '/business_information_chart';
  static String profitInformationChart = '/profit_information_chart';
  static String businessInformationPieChart = '/business_information_pie_chart';
  static String profitInformationPieChart = '/profit_information_pie_chart';
  static String profitInformationGroupBarChart =
      '/profit_information_group_bar_chart';

  //Thông tin sản xuất
  static String manufacturingInformation = '/manufacturing_information';
}
