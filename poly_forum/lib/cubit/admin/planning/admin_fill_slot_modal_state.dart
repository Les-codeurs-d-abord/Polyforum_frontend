part of 'admin_fill_slot_modal_cubit.dart';

@immutable
abstract class AdminFillSlotModalState {}

class AdminFillSlotModalInitial extends AdminFillSlotModalState {}

class AdminFillSlotModalLoading extends AdminFillSlotModalState {}

class AdminFillSlotModalLoadedCreation extends AdminFillSlotModalState {}

class AdminFillSlotModalLoaded extends AdminFillSlotModalState {
  final List<CompanyMinimal> listCompanies;

  AdminFillSlotModalLoaded(this.listCompanies);
}

class AdminFillSlotModalError extends AdminFillSlotModalState {
  final String msg;

  AdminFillSlotModalError(this.msg);
}
