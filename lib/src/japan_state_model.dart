class JapanStataModel{
  final String? id;
  final String? name;
  final String? short;
  final String? kana;
  final String? en;
  final List<City>? city;

  const JapanStataModel({
    this.id,
    this.name,
    this.short,
    this.kana,
    this.en,
    this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'short': short,
      'kana': kana,
      'en': en,
      'city': city,
    };
  }

  factory JapanStataModel.fromMap(Map<String, dynamic> map) {
    final cityMaps =  map['city'] as List<dynamic>;
    var city = <City>[];
    for(var f in cityMaps) {
      city.add(City.fromMap(f));
    }
    return JapanStataModel(
      id: map['id'] as String,
      name: map['name'] as String,
      short: map['short'] as String,
      kana: map['kana'] as String,
      en: map['en'] as String,
      city: city,
    );
  }

  JapanStataModel copyWith({
    String? id,
    String? name,
    String? short,
    String? kana,
    String? en,
    List<City>? city,
  }) {
    return JapanStataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      short: short ?? this.short,
      kana: kana ?? this.kana,
      en: en ?? this.en,
      city: city ?? this.city,
    );
  }

  @override
  String toString() {
    return 'JapanStatusModel{id: $id, name: $name, short: $short, kana: $kana, en: $en, city: $city}';
  }
}

class City {
  final String citycode;
  final String city;

//<editor-fold desc="Data Methods">

  const City({
    required this.citycode,
    required this.city,
  });

  @override
  String toString() {
    return 'City{ citycode: $citycode, city: $city,}';
  }

  City copyWith({
    String? citycode,
    String? city,
  }) {
    return City(
      citycode: citycode ?? this.citycode,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'citycode': citycode,
      'city': city,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      citycode: map['citycode'] as String,
      city: map['city'] as String,
    );
  }

//</editor-fold>
}