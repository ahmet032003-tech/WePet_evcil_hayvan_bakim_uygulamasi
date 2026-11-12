class UserAddressModel {
  final String id;
  final String title;
  final String fullAddress;

  const UserAddressModel({
    required this.id,
    required this.title,
    required this.fullAddress,
  });
}

class UserPaymentCardModel {
  final String id;
  final String cardHolder;
  final String lastFourDigits;

  const UserPaymentCardModel({
    required this.id,
    required this.cardHolder,
    required this.lastFourDigits,
  });
}

