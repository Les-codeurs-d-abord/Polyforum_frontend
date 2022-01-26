part of 'admin_fill_slot_modal_company_cubit.dart';

@immutable
abstract class AdminFillSlotModalState {}

class AdminFillSlotModalInitial extends AdminFillSlotModalState {}

class AdminFillSlotModalLoading extends AdminFillSlotModalState {}

class AdminFillSlotModalLoadedCreation extends AdminFillSlotModalState {}

class AdminFillSlotModalLoadingCreation extends AdminFillSlotModalState {}

class AdminFillSlotModalLoaded extends AdminFillSlotModalState {
  final List<CandidateMinimal> listCandidates;

  AdminFillSlotModalLoaded(this.listCandidates);
}

class AdminFillSlotModalError extends AdminFillSlotModalState {
  final String msg;

  AdminFillSlotModalError(this.msg);
}
