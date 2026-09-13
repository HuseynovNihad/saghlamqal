part of 'dietitians_bloc.dart';

sealed class DietitiansState extends Equatable {
  const DietitiansState();
  
  @override
  List<Object> get props => [];
}

final class DietitiansInitial extends DietitiansState {}
