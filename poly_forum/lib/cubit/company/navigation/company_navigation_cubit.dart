import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'company_navigation_state.dart';

class CompanyNavigationCubit extends Cubit<CompanyNavigationState> {
  int selectedIndex = 0;

  CompanyNavigationCubit() : super(CompanyNavigationLoaded(0));

  void setSelectedItem(int index) {
    selectedIndex = index;
    emit(CompanyNavigationLoaded(selectedIndex));
  }

  int getSelectedIndex() {
    return selectedIndex;
  }
}
