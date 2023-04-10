// To parse this JSON data, do
//
//     final detail = detailFromMap(jsonString);

import 'dart:convert';

Detail detailFromMap(String str) => Detail.fromMap(json.decode(str));

String detailToMap(Detail data) => json.encode(data.toMap());

class Detail {
    Detail({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    int? code;
    String? status;
    String? message;
    Data? data;

    factory Detail.fromMap(Map<String, dynamic> json) => Detail(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class Data {
    Data({
        this.number,
        this.sequence,
        this.numberOfVerses,
        this.name,
        this.revelation,
        this.tafsir,
        this.preBismillah,
        this.verses,
    });

    int? number;
    int? sequence;
    int? numberOfVerses;
    Name? name;
    Revelation? revelation;
    DataTafsir? tafsir;
    dynamic preBismillah;
    List<Verse>? verses;

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        number: json["number"],
        sequence: json["sequence"],
        numberOfVerses: json["numberOfVerses"],
        name: json["name"] == null ? null : Name.fromMap(json["name"]),
        revelation: json["revelation"] == null ? null : Revelation.fromMap(json["revelation"]),
        tafsir: json["tafsir"] == null ? null : DataTafsir.fromMap(json["tafsir"]),
        preBismillah: json["preBismillah"],
        verses: json["verses"] == null ? [] : List<Verse>.from(json["verses"]!.map((x) => Verse.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "number": number,
        "sequence": sequence,
        "numberOfVerses": numberOfVerses,
        "name": name?.toMap(),
        "revelation": revelation?.toMap(),
        "tafsir": tafsir?.toMap(),
        "preBismillah": preBismillah,
        "verses": verses == null ? [] : List<dynamic>.from(verses!.map((x) => x.toMap())),
    };
}

class Name {
    Name({
        this.short,
        this.long,
        this.transliteration,
        this.translation,
    });

    String? short;
    String? long;
    Translation? transliteration;
    Translation? translation;

    factory Name.fromMap(Map<String, dynamic> json) => Name(
        short: json["short"],
        long: json["long"],
        transliteration: json["transliteration"] == null ? null : Translation.fromMap(json["transliteration"]),
        translation: json["translation"] == null ? null : Translation.fromMap(json["translation"]),
    );

    Map<String, dynamic> toMap() => {
        "short": short,
        "long": long,
        "transliteration": transliteration?.toMap(),
        "translation": translation?.toMap(),
    };
}

class Translation {
    Translation({
        this.en,
        this.id,
    });

    String? en;
    String? id;

    factory Translation.fromMap(Map<String, dynamic> json) => Translation(
        en: json["en"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "en": en,
        "id": id,
    };
}

class Revelation {
    Revelation({
        this.arab,
        this.en,
        this.id,
    });

    String? arab;
    String? en;
    String? id;

    factory Revelation.fromMap(Map<String, dynamic> json) => Revelation(
        arab: json["arab"],
        en: json["en"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "arab": arab,
        "en": en,
        "id": id,
    };
}

class DataTafsir {
    DataTafsir({
        this.id,
    });

    String? id;

    factory DataTafsir.fromMap(Map<String, dynamic> json) => DataTafsir(
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
    };
}

class Verse {
    Verse({
        this.number,
        this.meta,
        this.text,
        this.translation,
        this.audio,
        this.tafsir,
    });

    Number? number;
    Meta? meta;
    Text? text;
    Translation? translation;
    Audio? audio;
    VerseTafsir? tafsir;

    factory Verse.fromMap(Map<String, dynamic> json) => Verse(
        number: json["number"] == null ? null : Number.fromMap(json["number"]),
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
        text: json["text"] == null ? null : Text.fromMap(json["text"]),
        translation: json["translation"] == null ? null : Translation.fromMap(json["translation"]),
        audio: json["audio"] == null ? null : Audio.fromMap(json["audio"]),
        tafsir: json["tafsir"] == null ? null : VerseTafsir.fromMap(json["tafsir"]),
    );

    Map<String, dynamic> toMap() => {
        "number": number?.toMap(),
        "meta": meta?.toMap(),
        "text": text?.toMap(),
        "translation": translation?.toMap(),
        "audio": audio?.toMap(),
        "tafsir": tafsir?.toMap(),
    };
}

class Audio {
    Audio({
        this.primary,
        this.secondary,
    });

    String? primary;
    List<String>? secondary;

    factory Audio.fromMap(Map<String, dynamic> json) => Audio(
        primary: json["primary"],
        secondary: json["secondary"] == null ? [] : List<String>.from(json["secondary"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "primary": primary,
        "secondary": secondary == null ? [] : List<dynamic>.from(secondary!.map((x) => x)),
    };
}

class Meta {
    Meta({
        this.juz,
        this.page,
        this.manzil,
        this.ruku,
        this.hizbQuarter,
        this.sajda,
    });

    int? juz;
    int? page;
    int? manzil;
    int? ruku;
    int? hizbQuarter;
    Sajda? sajda;

    factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        juz: json["juz"],
        page: json["page"],
        manzil: json["manzil"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: json["sajda"] == null ? null : Sajda.fromMap(json["sajda"]),
    );

    Map<String, dynamic> toMap() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda?.toMap(),
    };
}

class Sajda {
    Sajda({
        this.recommended,
        this.obligatory,
    });

    bool? recommended;
    bool? obligatory;

    factory Sajda.fromMap(Map<String, dynamic> json) => Sajda(
        recommended: json["recommended"],
        obligatory: json["obligatory"],
    );

    Map<String, dynamic> toMap() => {
        "recommended": recommended,
        "obligatory": obligatory,
    };
}

class Number {
    Number({
        this.inQuran,
        this.inSurah,
    });

    int? inQuran;
    int? inSurah;

    factory Number.fromMap(Map<String, dynamic> json) => Number(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
    );

    Map<String, dynamic> toMap() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
    };
}

class VerseTafsir {
    VerseTafsir({
        this.id,
    });

    Id? id;

    factory VerseTafsir.fromMap(Map<String, dynamic> json) => VerseTafsir(
        id: json["id"] == null ? null : Id.fromMap(json["id"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id?.toMap(),
    };
}

class Id {
    Id({
        this.short,
        this.long,
    });

    String? short;
    String? long;

    factory Id.fromMap(Map<String, dynamic> json) => Id(
        short: json["short"],
        long: json["long"],
    );

    Map<String, dynamic> toMap() => {
        "short": short,
        "long": long,
    };
}

class Text {
    Text({
        this.arab,
        this.transliteration,
    });

    String? arab;
    Transliteration? transliteration;

    factory Text.fromMap(Map<String, dynamic> json) => Text(
        arab: json["arab"],
        transliteration: json["transliteration"] == null ? null : Transliteration.fromMap(json["transliteration"]),
    );

    Map<String, dynamic> toMap() => {
        "arab": arab,
        "transliteration": transliteration?.toMap(),
    };
}

class Transliteration {
    Transliteration({
        this.en,
    });

    String? en;

    factory Transliteration.fromMap(Map<String, dynamic> json) => Transliteration(
        en: json["en"],
    );

    Map<String, dynamic> toMap() => {
        "en": en,
    };
}
