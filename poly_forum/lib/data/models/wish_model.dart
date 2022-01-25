import 'package:poly_forum/data/models/offer_model.dart';

class Wish {
  final int wishId;
  final int candidateId;
  final int offerId;
  final Offer offer;

  Wish({
    required this.wishId,
    required this.candidateId,
    required this.offerId,
    required this.offer,
  });

  factory Wish.fromJson(Map<String, dynamic> json, Offer offer) {
    return Wish(
      wishId: json['id'] ?? '',
      candidateId: json['candidateId'] ?? '',
      offerId: json['offerId'] ?? '',
      offer: offer,
    );
  }
}
