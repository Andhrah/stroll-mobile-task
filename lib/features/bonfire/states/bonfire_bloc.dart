import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroll/features/bonfire/states/bonfire_event.dart';
import 'bonfire_state.dart';

class BonfireBloc extends Bloc<BonfireEvent, BonfireState> {
  BonfireBloc() : super(BonfireInitial()) {
    on<OptionSelected>((event, emit) {
      emit(OptionSelectionChanged(event.option));
    });

    on<SubmitResponse>((event, emit) {
      if (state is OptionSelectionChanged) {
        final selectedOption = (state as OptionSelectionChanged).selectedOption;
        emit(AnswerSumbmitted(selectedOption));
      }
    });
  }
}
