part of 'company_offer_cubit.dart';

@immutable
abstract class CompanyOfferState {}

class CompanyOfferInitial extends CompanyOfferState {}

class CompanyOfferLoading extends CompanyOfferState {}

class CompanyOfferLoaded extends CompanyOfferState {
  final Offer offer;
  CompanyOfferLoaded(this.offer);
}

class CompanyOfferError extends CompanyOfferState {
  final String msg;
  CompanyOfferError(this.msg);
}
