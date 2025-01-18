import 'package:equatable/equatable.dart';

abstract class BonfireState extends Equatable {
  const BonfireState();

  @override
  List<Object> get props => [];
}

class BonfireInitial extends BonfireState {}

class OptionSelectionChanged extends BonfireState {
  final String selectedOption;

  const OptionSelectionChanged(this.selectedOption);

  @override
  List<Object> get props => [selectedOption];
}

class AnswerSumbmitted extends BonfireState {
  final String submittedOption;

  const AnswerSumbmitted(this.submittedOption);

  @override
  List<Object> get props => [submittedOption];
}
