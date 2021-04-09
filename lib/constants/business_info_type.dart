enum BusinessInfoType { Sale, Revenue, RealRevenue, ExpiredDebt }

extension ParseToString on BusinessInfoType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
