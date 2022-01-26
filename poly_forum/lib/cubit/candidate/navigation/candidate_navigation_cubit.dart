import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'candidate_navigation_state.dart';

class CandidateNavigationCubit extends Cubit<CandidateNavigationState> {
  int selectedIndex = 0;

  CandidateNavigationCubit() : super(CandidateNavigationLoaded(0));

  void setSelectedItem(int index) {
    selectedIndex = index;
    emit(CandidateNavigationLoaded(selectedIndex));
  }

  int getSelectedIndex() {
    return selectedIndex;
  }
}
