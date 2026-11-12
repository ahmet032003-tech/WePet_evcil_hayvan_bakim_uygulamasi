enum PetType { dog, cat }

class PetProfileModel {
  final String id;
  final String name;
  final PetType type;
  final String? breed;
  final int? age;

  const PetProfileModel({
    required this.id,
    required this.name,
    required this.type,
    this.breed,
    this.age,
  });
}

