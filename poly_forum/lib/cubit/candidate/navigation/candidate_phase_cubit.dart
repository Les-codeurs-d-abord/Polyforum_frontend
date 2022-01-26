import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'candidate_phase_state.dart';

class CandidatePhaseCubit extends Cubit<CandidatePhaseState> {
  CandidatePhaseCubit() : super(CandidatePhaseInitial());
}
