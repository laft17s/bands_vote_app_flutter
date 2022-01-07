// ignore: slash_for_doc_comments
/**
 * Band Model
 */

class Band {
  String bandId;
  String bandName;
  int bandCount;

  Band({
    required this.bandId,
    required this.bandName,
    required this.bandCount,
  });

  factory Band.fromMap(Map<String, dynamic> obj) => Band(
        bandId: obj['bandId'],
        bandName: obj['bandName'],
        bandCount: obj['bandCount'],
      );
}
