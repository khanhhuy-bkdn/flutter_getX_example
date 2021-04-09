enum ApproveStatus {
  NeedApprove,
  Recheck,
  RejectionApproved,
  Approved,
}

extension ParseToString on ApproveStatus {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
