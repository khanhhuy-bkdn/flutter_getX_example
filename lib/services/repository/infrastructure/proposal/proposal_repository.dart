import 'package:flutter_demo_getx/models/approve_history.model.dart';
import 'package:flutter_demo_getx/models/product_inventory.model.dart';
import 'package:flutter_demo_getx/models/proposal/filter_proposal_model.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_approve.request.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_info.model.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_result_model.dart';
import 'package:flutter_demo_getx/services/provider/i_api_provider.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/proposal/i_proposal_repository.dart';

class ProposalRepository implements IProposalRepository {
  ProposalRepository({required this.apiProvider});
  final IApiProvider apiProvider;

  @override
  Future<ProposalResultModel?> filter(
      FilterProposalModel filterProposal) async {
    final params = {
      'dateFrom': filterProposal.fromDate != null
          ? (filterProposal.fromDate!.millisecondsSinceEpoch / 1000).round()
          : null,
      'dateTo': filterProposal.toDate != null
          ? (filterProposal.toDate!.millisecondsSinceEpoch / 1000).round()
          : null,
      'employeeId': filterProposal.employee?.id ?? null,
      'type': filterProposal.type?.value ?? null,
      'commodityType': filterProposal.commodityType?.value ?? null,
      'approveStatus': filterProposal.approvedStatus?.value ?? null,
      'searchKey': filterProposal.searchKey,
      'branchId': filterProposal.branch?.id ?? null
    };

    try {
      final response = await apiProvider.get(
          'purchaseproposal/filterproposal/${filterProposal.page}/${filterProposal.pageSize}',
          params: params);
      if (response != null) {
        return ProposalResultModel.fromJson(response as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (error, stacktrace) {
      print('Error occurred $error\n Stacktrace: $stacktrace}');
      return null;
    }
  }

  @override
  Future<ProposalInfoModel> getProposalInfo(int id) async {
    final response = await apiProvider.get('purchaseproposal/${id}');
    if (response != null) {
      return ProposalInfoModel.fromJson(response as Map<String, dynamic>);
    }
    return ProposalInfoModel();
  }

  @override
  Future<bool> approveProposal(ProposalApproveRequest data) async {
    final response =
        await apiProvider.post('purchaseproposal/approve', data.toJson());
    return response != null;
  }

  @override
  Future<ProductInventoryModel> getProductInventory(int productId) async {
    final response =
        await apiProvider.get('inventory/get-total?productId=${productId}');
    if (response != null) {
      return ProductInventoryModel.fromJson(response as Map<String, dynamic>);
    }
    return ProductInventoryModel();
  }

  @override
  Future<List<ApproveHistoryModel>?> getApproveHistory(
      int objectId, String type) async {
    final response =
        await apiProvider.get('${type}/approval-detail/${objectId}');
    if (response != null) {
      return (response as List)
          .map((e) => ApproveHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return null;
  }
}
