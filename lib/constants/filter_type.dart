enum FilterType { Customer, ProductGroup }

extension ParseToString on FilterType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
