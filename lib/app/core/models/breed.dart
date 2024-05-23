import 'package:equatable/equatable.dart';

class Breed extends Equatable {
  final String id;
  final String name;
  final String temperament;
  final String origin;
  final String description;
  final String lifeSpan;
  final String referenceImageId;
  final String imageUrl;
  final String weight;
  final String? wikipediaUrl;
  final String countryCodes;
  final String countryCode;
  final String? breedGroup;
  final bool experimental;
  final bool hairless;
  final bool natural;
  final bool rare;
  final bool rex;
  final bool suppressedTail;
  final bool shortLegs;
  final bool hypoallergenic;

  const Breed({
    required this.id,
    required this.name,
    required this.temperament,
    required this.origin,
    required this.description,
    required this.lifeSpan,
    required this.referenceImageId,
    required this.imageUrl,
    required this.weight,
    this.wikipediaUrl,
    required this.countryCodes,
    required this.countryCode,
    this.breedGroup,
    required this.experimental,
    required this.hairless,
    required this.natural,
    required this.rare,
    required this.rex,
    required this.suppressedTail,
    required this.shortLegs,
    required this.hypoallergenic,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        temperament,
        origin,
        description,
        lifeSpan,
        referenceImageId,
        imageUrl,
        weight,
        wikipediaUrl,
        countryCodes,
        countryCode,
        breedGroup,
        experimental,
        hairless,
        natural,
        rare,
        rex,
        suppressedTail,
        shortLegs,
        hypoallergenic,
      ];

  Breed copyWith({
    String? id,
    String? name,
    String? temperament,
    String? origin,
    String? description,
    String? lifeSpan,
    String? referenceImageId,
    String? imageUrl,
    String? weight,
    String? wikipediaUrl,
    String? countryCodes,
    String? countryCode,
    String? breedGroup,
    bool? experimental,
    bool? hairless,
    bool? natural,
    bool? rare,
    bool? rex,
    bool? suppressedTail,
    bool? shortLegs,
    bool? hypoallergenic,
  }) {
    return Breed(
      id: id ?? this.id,
      name: name ?? this.name,
      temperament: temperament ?? this.temperament,
      origin: origin ?? this.origin,
      description: description ?? this.description,
      lifeSpan: lifeSpan ?? this.lifeSpan,
      referenceImageId: referenceImageId ?? this.referenceImageId,
      imageUrl: imageUrl ?? this.imageUrl,
      weight: weight ?? this.weight,
      wikipediaUrl: wikipediaUrl ?? this.wikipediaUrl,
      countryCodes: countryCodes ?? this.countryCodes,
      countryCode: countryCode ?? this.countryCode,
      breedGroup: breedGroup ?? this.breedGroup,
      experimental: experimental ?? this.experimental,
      hairless: hairless ?? this.hairless,
      natural: natural ?? this.natural,
      rare: rare ?? this.rare,
      rex: rex ?? this.rex,
      suppressedTail: suppressedTail ?? this.suppressedTail,
      shortLegs: shortLegs ?? this.shortLegs,
      hypoallergenic: hypoallergenic ?? this.hypoallergenic,
    );
  }

  factory Breed.fromMap(Map<String, dynamic> map) {
    return Breed(
      id: map['id'] as String,
      name: map['name'] as String,
      temperament: map['temperament'] as String,
      origin: map['origin'] as String,
      description: map['description'] as String,
      lifeSpan: map['life_span'] as String,
      referenceImageId: map['reference_image_id'] as String? ?? '',
      imageUrl: '', // Inicializar con una cadena vacía
      weight: map['weight']['imperial'] as String? ?? '',
      wikipediaUrl: map['wikipedia_url'] as String?,
      countryCodes: map['country_codes'] as String? ?? '',
      countryCode: map['country_code'] as String? ?? '',
      breedGroup: map['breed_group'] as String?,
      experimental: (map['experimental'] is int)
          ? (map['experimental'] == 1)
          : (map['experimental'] as bool? ?? false),
      hairless:
          (map['hairless'] is int) ? (map['hairless'] == 1) : (map['hairless'] as bool? ?? false),
      natural: (map['natural'] is int) ? (map['natural'] == 1) : (map['natural'] as bool? ?? false),
      rare: (map['rare'] is int) ? (map['rare'] == 1) : (map['rare'] as bool? ?? false),
      rex: (map['rex'] is int) ? (map['rex'] == 1) : (map['rex'] as bool? ?? false),
      suppressedTail: (map['suppressed_tail'] is int)
          ? (map['suppressed_tail'] == 1)
          : (map['suppressed_tail'] as bool? ?? false),
      shortLegs: (map['short_legs'] is int)
          ? (map['short_legs'] == 1)
          : (map['short_legs'] as bool? ?? false),
      hypoallergenic: (map['hypoallergenic'] is int)
          ? (map['hypoallergenic'] == 1)
          : (map['hypoallergenic'] as bool? ?? false),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'temperament': temperament,
      'origin': origin,
      'description': description,
      'life_span': lifeSpan,
      'reference_image_id': referenceImageId,
      'image_url': imageUrl,
      'weight': weight,
      'wikipedia_url': wikipediaUrl,
      'country_codes': countryCodes,
      'country_code': countryCode,
      'breed_group': breedGroup,
      'experimental': experimental,
      'hairless': hairless,
      'natural': natural,
      'rare': rare,
      'rex': rex,
      'suppressed_tail': suppressedTail,
      'short_legs': shortLegs,
      'hypoallergenic': hypoallergenic,
    };
  }

  static const empty = Breed(
    id: '',
    name: '',
    temperament: '',
    origin: '',
    description: '',
    lifeSpan: '',
    referenceImageId: '',
    imageUrl: '',
    weight: '',
    wikipediaUrl: '',
    countryCodes: '',
    countryCode: '',
    breedGroup: '',
    experimental: false,
    hairless: false,
    natural: false,
    rare: false,
    rex: false,
    suppressedTail: false,
    shortLegs: false,
    hypoallergenic: false,
  );
}
