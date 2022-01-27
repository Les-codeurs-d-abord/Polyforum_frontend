import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'company_phase_state.dart';

class CompanyPhaseCubit extends Cubit<CompanyPhaseState> {
  CompanyPhaseCubit() : super(CompanyPhaseInitial());
}
