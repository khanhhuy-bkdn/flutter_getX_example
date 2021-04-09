import 'package:flutter_demo_getx/models/approve_history.model.dart';
import 'package:flutter_demo_getx/models/product_inventory.model.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_approve.request.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_info.model.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/proposal/i_proposal_repository.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProposalController extends GetxController {
  ProposalController({required this.proposalRepository});
  final IProposalRepository proposalRepository;

  bool isLoadingProposal = false;
  bool isLoadingApproveList = false;
  bool isLoadingInventoryDetail = false;

  ProposalInfoModel? proposal;
  ProductInventoryModel productInventory = ProductInventoryModel(
      onHandQty: 0,
      allocationPlan: 0,
      availableQty: 0,
      purchaseOrderQty: 0,
      saleOrderQty: 0,
      transitInQty: 0,
      transitOutQty: 0);
  List<ApproveHistoryModel>? approveHistoryList;

  Future getProposal(int id) async {
    isLoadingProposal = true;
    update();
    proposal = await proposalRepository.getProposalInfo(id);
    isLoadingProposal = false;
    update();
  }

  Future<bool> approveProposal(ProposalApproveRequest data) async {
    bool approved = await proposalRepository.approveProposal(data);
    if (approved) {
      getProposal(data.id);
    }
    return approved;
  }

  Future getProductInventory(int productId) async {
    isLoadingInventoryDetail = true;
    update();
    productInventory = await proposalRepository.getProductInventory(productId);
    isLoadingInventoryDetail = false;
    update();
  }

  Future getApproveHistoryList(int objectId, String type) async {
    approveHistoryList?.clear();
    isLoadingApproveList = true;
    update();
    approveHistoryList =
        await proposalRepository.getApproveHistory(objectId, type);
    isLoadingApproveList = false;
    update();
  }
}
