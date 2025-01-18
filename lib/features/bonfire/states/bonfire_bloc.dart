import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroll/features/bonfire/states/bonfire_event.dart';
import 'bonfire_state.dart';

class BonfireBloc extends Bloc<BonfireEvent, BonfireState> {
  // A simple cache to store the selected option
  String? _cachedOption;

  BonfireBloc() : super(BonfireInitial()) {
    on<OptionSelected>((event, emit) {
      // Cache the selected option
      _cachedOption = event.option;
      // Emit the new state with the selected option
      emit(OptionSelectionChanged(event.option));
    });

    on<SubmitResponse>((event, emit) {
      if (_cachedOption != null) {
        emit(AnswerSumbmitted(_cachedOption!));
      } else if (state is OptionSelectionChanged) {
        final selectedOption = (state as OptionSelectionChanged).selectedOption;
        emit(AnswerSumbmitted(selectedOption));
      } else {
        emit(OptionSelectionChanged('No option selected.'));
      }
    });
  }
}
