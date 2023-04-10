// To parse this JSON data, do
//
//     final quranApi = quranApiFromMap(jsonString);

import 'dart:convert';

QuranApi quranApiFromMap(String str) => QuranApi.fromMap(json.decode(str));

String quranApiToMap(QuranApi data) => json.encode(data.toMap());

class QuranApi {
    QuranApi({
        this.code,
        this.status,
        this.data,
    });

    int? code;
    String? status;
    Data? data;

    factory QuranApi.fromMap(Map<String, dynamic> json) => QuranApi(
        code: json["code"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "data": data?.toMap(),
    };
}

class Data {
    Data({
        this.surahs,
        this.edition,
    });

    List<Surah>? surahs;
    Edition? edition;

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        surahs: json["surahs"] == null ? [] : List<Surah>.from(json["surahs"]!.map((x) => Surah.fromMap(x))),
        edition: json["edition"] == null ? null : Edition.fromMap(json["edition"]),
    );

    Map<String, dynamic> toMap() => {
        "surahs": surahs == null ? [] : List<dynamic>.from(surahs!.map((x) => x.toMap())),
        "edition": edition?.toMap(),
    };
}

class Edition {
    Edition({
        this.identifier,
        this.language,
        this.name,
        this.englishName,
        this.format,
        this.type,
    });

    String? identifier;
    String? language;
    String? name;
    String? englishName;
    String? format;
    String? type;

    factory Edition.fromMap(Map<String, dynamic> json) => Edition(
        identifier: json["identifier"],
        language: json["language"],
        name: json["name"],
        englishName: json["englishName"],
        format: json["format"],
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "identifier": identifier,
        "language": language,
        "name": name,
        "englishName": englishName,
        "format": format,
        "type": type,
    };
}

class Surah {
    Surah({
        this.number,
        this.name,
        this.englishName,
        this.englishNameTranslation,
        this.revelationType,
        this.ayahs,
    });

    int? number;
    String? name;
    String? englishName;
    String? englishNameTranslation;
    RevelationType? revelationType;
    List<Ayah>? ayahs;

    factory Surah.fromMap(Map<String, dynamic> json) => Surah(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        revelationType: revelationTypeValues.map[json["revelationType"]]!,
        ayahs: json["ayahs"] == null ? [] : List<Ayah>.from(json["ayahs"]!.map((x) => Ayah.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "number": number,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "revelationType": revelationTypeValues.reverse[revelationType],
        "ayahs": ayahs == null ? [] : List<dynamic>.from(ayahs!.map((x) => x.toMap())),
    };
}

class Ayah {
    Ayah({
        this.number,
        this.audio,
        this.audioSecondary,
        this.text,
        this.numberInSurah,
        this.juz,
        this.manzil,
        this.page,
        this.ruku,
        this.hizbQuarter,
        this.sajda,
    });

    int? number;
    String? audio;
    List<String>? audioSecondary;
    String? text;
    int? numberInSurah;
    int? juz;
    int? manzil;
    int? page;
    int? ruku;
    int? hizbQuarter;
    dynamic sajda;

    factory Ayah.fromMap(Map<String, dynamic> json) => Ayah(
        number: json["number"],
        audio: json["audio"],
        audioSecondary: json["audioSecondary"] == null ? [] : List<String>.from(json["audioSecondary"]!.map((x) => x)),
        text: json["text"],
        numberInSurah: json["numberInSurah"],
        juz: json["juz"],
        manzil: json["manzil"],
        page: json["page"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: json["sajda"],
    );

    Map<String, dynamic> toMap() => {
        "number": number,
        "audio": audio,
        "audioSecondary": audioSecondary == null ? [] : List<dynamic>.from(audioSecondary!.map((x) => x)),
        "text": text,
        "numberInSurah": numberInSurah,
        "juz": juz,
        "manzil": manzil,
        "page": page,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda,
    };
}

class SajdaClass {
    SajdaClass({
        this.id,
        this.recommended,
        this.obligatory,
    });

    int? id;
    bool? recommended;
    bool? obligatory;

    factory SajdaClass.fromMap(Map<String, dynamic> json) => SajdaClass(
        id: json["id"],
        recommended: json["recommended"],
        obligatory: json["obligatory"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "recommended": recommended,
        "obligatory": obligatory,
    };
}

enum RevelationType { MECCAN, MEDINAN }

final revelationTypeValues = EnumValues({
    "Meccan": RevelationType.MECCAN,
    "Medinan": RevelationType.MEDINAN
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
