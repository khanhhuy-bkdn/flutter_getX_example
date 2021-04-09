import 'package:flutter_demo_getx/models/proposal/filter_proposal_model.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_model.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_result_model.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/proposal/i_proposal_repository.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FilterProposalController extends GetxController {
  FilterProposalController({required this.proposalRepository});
  final IProposalRepository proposalRepository;

  List<ProposalModel>? listResult = [];
  FilterProposalModel? filterProposalResult;
  ProposalResultModel? proposalResult;
  bool isLoading = true;
  bool canLoadMore = true;
  Future filter(FilterProposalModel? filterProposal) async {
    isLoading = true;
    // ignore: unnecessary_null_comparison
    if (filterProposal == null) {
      filterProposal = new FilterProposalModel(
          page: 0,
          pageSize: 20,
          toDate: DateTime.now(),
          fromDate: new DateTime(DateTime.now().year, DateTime.now().month, 1));
    }

    await proposalRepository.filter(filterProposal).then((value) {
      if (value != null) {
        if (filterProposal!.page == 0) {
          listResult?.clear();
        }
        filterProposalResult = filterProposal;

        proposalResult = value;
        if (filterProposal.page > 0) {
          listResult?.addAll(proposalResult!.items!);
        } else {
          listResult = proposalResult!.items ?? [];
        }
        canLoadMore =
            proposalResult!.pageIndex! < proposalResult!.totalPages! &&
                proposalResult!.totalPages! > 1;
      } else {
        filterProposal!.approvedStatus = null;
      }
    });
    isLoading = false;

    update();
  }
}
