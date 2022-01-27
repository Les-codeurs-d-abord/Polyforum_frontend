part of 'company_get_offer_cubit.dart';

@immutable
abstract class CompanyGetOfferState {}

class CompanyGetOfferInitial extends CompanyGetOfferState {}

class CompanyGetOfferLoading extends CompanyGetOfferState {}

class CompanyGetOfferEditPageLoaded extends CompanyGetOfferState {
  final Offer offer;
  CompanyGetOfferEditPageLoaded(this.offer);
}

class CompanyGetOfferLoaded extends CompanyGetOfferState {
  final List<Offer> offerList;
  CompanyGetOfferLoaded(this.offerList);
}

class CompanyGetOfferLoadedWithFilter extends CompanyGetOfferState {
  final List<Offer> offerList;
  CompanyGetOfferLoadedWithFilter(this.offerList);
}

class CompanyGetOfferError extends CompanyGetOfferState {
  final String msg;
  CompanyGetOfferError(this.msg);
}
