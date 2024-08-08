class HomeModel {
  List<CandidatesModel>? candidates;

  HomeModel({this.candidates});

  factory HomeModel.mapToModel(Map m1) {
    List l1 = m1['candidates'];
    return HomeModel(
      candidates: l1.map((e) => CandidatesModel.mapToModel(e)).toList(),
    );
  }
}

class CandidatesModel {
  String? finishReason;
  int? index;
  List<SafetyRatingsModel>? safetyRating;
  ContentModel? content;

  CandidatesModel(
      {this.finishReason, this.index, this.safetyRating, this.content});

  factory CandidatesModel.mapToModel(Map m1) {
    List l1 = m1['safetyRatings'];
    return CandidatesModel(
      finishReason: m1['finishReason'],
      index: m1['index'],
      safetyRating: l1.map((e) => SafetyRatingsModel.mapToModel(e)).toList(),
      content: ContentModel.mapToModel(m1['content']),
    );
  }
}

class ContentModel {
  String? role;
  List<PartsModel>? parts;

  ContentModel({this.role, this.parts});

  factory ContentModel.mapToModel(Map m1) {
    List l1 = m1['parts'];
    return ContentModel(
      role: m1['role'],
      parts: l1.map((e) => PartsModel.mapToModel(e)).toList(),
    );
  }
}

class PartsModel {
  String? text;

  PartsModel({this.text});

  factory PartsModel.mapToModel(Map m1) {
    return PartsModel(
      text: m1['text'],
    );
  }
}

class SafetyRatingsModel {
  String? category, probability;

  SafetyRatingsModel({this.category, this.probability});

  factory SafetyRatingsModel.mapToModel(Map m1) {
    return SafetyRatingsModel(
      category: m1['category'],
      probability: m1['probability'],
    );
  }
}
