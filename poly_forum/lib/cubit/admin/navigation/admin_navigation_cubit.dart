import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/utils/constants.dart';

part 'admin_navigation_state.dart';

class AdminNavigationCubit extends Cubit<AdminNavigationState> {
  int selectedIndex = 1;

  AdminNavigationCubit() : super(AdminNavigationLoaded(1));

  void setSelectedItem(int index) {
    selectedIndex = index;
    emit(AdminNavigationLoaded(selectedIndex));
  }

  Future<void> refreshSelectedItem() async {
    emit(AdminNavigationInitial());
    await Future.delayed(const Duration(milliseconds: kDelayQuery));
    emit(AdminNavigationLoaded(selectedIndex));
  }

  int getSelectedIndex() {
    return selectedIndex;
  }
}
