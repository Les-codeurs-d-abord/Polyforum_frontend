part of 'drop_down_offer_tag_cubit.dart';

@immutable
abstract class DropDownOfferTagState {}

class DropDownOfferTagInitial extends DropDownOfferTagState {}

class DropDownOfferTagLoading extends DropDownOfferTagState {}

class DropDownOfferTagLoaded extends DropDownOfferTagState {
  final List<Tag> tags;

  DropDownOfferTagLoaded(this.tags);

  @override
  String toString() => "{ User: ${tags.toString()} }";
}

class DropDownOfferTagError extends DropDownOfferTagState {
  final String msg;

  DropDownOfferTagError(this.msg);
}
