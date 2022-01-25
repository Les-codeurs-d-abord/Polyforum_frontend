import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'phase_state.dart';

class PhaseCubit extends Cubit<PhaseState> {
  PhaseCubit() : super(PhaseInitial());
}
