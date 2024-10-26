part of 'income_statistic_bloc.dart';

abstract class IncomeStatisticState extends Equatable {
  const IncomeStatisticState();
  
  @override
  List<Object> get props => [];
}

class IncomeStatisticInitial extends IncomeStatisticState {}

class GetIncomePeding extends IncomeStatisticState {}

class GetIncomeFailed extends IncomeStatisticState {
  final String message;

  const GetIncomeFailed({
    required this.message
  });

  @override
  List<Object> get props => [
    message
  ];
}

class GetIncomeSuccess extends IncomeStatisticState {
  final ApiResponse apiResponse;

  const GetIncomeSuccess({
    required this.apiResponse
  });

  @override
  List<Object> get props => [
    apiResponse
  ];
}
