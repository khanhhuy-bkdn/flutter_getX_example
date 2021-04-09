// ignore: one_member_abstracts
import 'package:flutter_demo_getx/models/approve_history.model.dart';
import 'package:flutter_demo_getx/models/product_inventory.model.dart';
import 'package:flutter_demo_getx/models/proposal/filter_proposal_model.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_approve.request.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_info.model.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_result_model.dart';

abstract class IProposalRepository {
  Future<ProposalResultModel?> filter(FilterProposalModel filterProposal);
  Future<ProposalInfoModel> getProposalInfo(int id);
  Future<bool> approveProposal(ProposalApproveRequest data);
  Future<ProductInventoryModel> getProductInventory(int productId);
  Future<List<ApproveHistoryModel>?> getApproveHistory(
      int objectId, String type);
}
