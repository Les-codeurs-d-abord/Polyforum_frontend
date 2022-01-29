part of 'company_offers_list_dialog_cubit.dart';

@immutable
abstract class CompanyOffersListDialogState extends Equatable {
  const CompanyOffersListDialogState();

  @override
  List<Object> get props => [];
}

class CompanyOffersListDialogInitial extends CompanyOffersListDialogState {}

class CompanyOffersListDialogLoading extends CompanyOffersListDialogState {}

class CompanyOffersListDialogLoaded extends CompanyOffersListDialogState {
  final List<Offer> offersList;

  const CompanyOffersListDialogLoaded(this.offersList);

  @override
  List<Object> get props => [offersList];
}

class CompanyOffersListDialogDelete extends CompanyOffersListDialogState {
  final Offer deletedOffer;

  const CompanyOffersListDialogDelete(this.deletedOffer);

  @override
  List<Object> get props => [deletedOffer];
}

class CompanyOffersListDialogError extends CompanyOffersListDialogState {
  final String errorMessage;

  const CompanyOffersListDialogError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class CompanyOffersListDialogSnackBarError extends CompanyOffersListDialogState {
  final String errorMessage;

  const CompanyOffersListDialogSnackBarError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
