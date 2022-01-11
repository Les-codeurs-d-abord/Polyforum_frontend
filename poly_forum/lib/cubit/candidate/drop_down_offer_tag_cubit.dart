import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'drop_down_offer_tag_state.dart';

class DropDownOfferTagCubit extends Cubit<DropDownOfferTagState> {
  final CandidateRepository repository = CandidateRepository();

  DropDownOfferTagCubit() : super(DropDownOfferTagInitial());

  Future<void> offerTagsEvent() async {
    try {
      emit(DropDownOfferTagLoading());

      final tags = await repository.fetchOfferTags();

      emit(DropDownOfferTagLoaded(tags));
    } on NetworkException catch (exception) {
      emit(DropDownOfferTagError(exception.message));
    }
  }
}
