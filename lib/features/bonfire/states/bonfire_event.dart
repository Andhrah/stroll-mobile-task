import 'package:equatable/equatable.dart';

abstract class BonfireEvent extends Equatable {
  const BonfireEvent();

  @override
  List<Object?> get props => [];
}

class OptionSelected extends BonfireEvent {
  final String option;

  const OptionSelected(this.option);

  @override
  List<Object?> get props => [option];
}

class SubmitResponse extends BonfireEvent {
  const SubmitResponse();
}