import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_offers_list_dialog_state.dart';

class CompanyOffersListDialogCubit extends Cubit<CompanyOffersListDialogState> {
  final CompanyRepository _companyRepository;

  CompanyOffersListDialogCubit(this._companyRepository) : super(CompanyOffersListDialogInitial());

  Future<void> fetchOffersFromCompany(int companyId) async {
    try {
      emit(CompanyOffersListDialogLoading());

      List<Offer> offersList = await _companyRepository.fetchOffersFromCompany(companyId);

      emit(CompanyOffersListDialogLoaded(offersList));
    } on NetworkException catch (exception) {
      emit(CompanyOffersListDialogError(exception.message));
    } on CompanyException catch (exception) {
      emit(CompanyOffersListDialogError(exception.message));
    } on Exception catch (_) {
      emit(const CompanyOffersListDialogError("Une erreur inconnue est survenue"));
    }
  }

  Future<void> deleteOffer(Offer offer) async {
    try {
      emit(CompanyOffersListDialogLoading());

      await _companyRepository.deleteOffer(offer);

      emit(CompanyOffersListDialogDelete(offer));
    } on NetworkException catch (exception) {
      emit(CompanyOffersListDialogSnackBarError(exception.message));
    } on Exception catch (_) {
      emit(const CompanyOffersListDialogSnackBarError("Une erreur inconnue est survenue"));
    }
  }
}
