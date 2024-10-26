// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'income_statistic_bloc.dart';

abstract class IncomeStatisticEvent extends Equatable {
  const IncomeStatisticEvent();

  @override
  List<Object> get props => [];
}

class GetIncome extends IncomeStatisticEvent {
  final String type;
  final String id;

  const GetIncome({
    required this.type,
    required this.id,
  });

  @override
  List<Object> get props => [
    type,
    id
  ];
}
