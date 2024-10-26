class IncomeStatisticModel {
  final double incomeTotal;
  final int deliveryTotal;
  final double moveTotal;
  IncomeStatisticModel({
    required this.incomeTotal,
    required this.deliveryTotal,
    required this.moveTotal,
  });


  IncomeStatisticModel copyWith({
    double? incomeTotal,
    int? deliveryTotal,
    double? moveTotal,
  }) {
    return IncomeStatisticModel(
      incomeTotal: incomeTotal ?? this.incomeTotal,
      deliveryTotal: deliveryTotal ?? this.deliveryTotal,
      moveTotal: moveTotal ?? this.moveTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'incomeTotal': incomeTotal,
      'deliveryTotal': deliveryTotal,
      'moveTotal': moveTotal,
    };
  }

  factory IncomeStatisticModel.fromMap(Map<String, dynamic> map) {
    return IncomeStatisticModel(
      incomeTotal: double.parse(map['incomeTotal']),
      deliveryTotal: int.parse(map['deliveryTotal']),
      moveTotal: double.parse(map['moveTotal']),
    );
  }
}
