class MoodlyResponseModel {
  Data? data;

  MoodlyResponseModel({this.data});

  MoodlyResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Dance? dance;
  Mood? mood;
  Energy? energy;

  Data({this.dance, this.mood, this.energy});

  Data.fromJson(Map<String, dynamic> json) {
    dance = json['dance'] != null ? new Dance.fromJson(json['dance']) : null;
    mood = json['mood'] != null ? new Mood.fromJson(json['mood']) : null;
    energy =
        json['energy'] != null ? new Energy.fromJson(json['energy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dance != null) {
      data['dance'] = this.dance!.toJson();
    }
    if (this.mood != null) {
      data['mood'] = this.mood!.toJson();
    }
    if (this.energy != null) {
      data['energy'] = this.energy!.toJson();
    }
    return data;
  }
}

class Dance {
  Party? party;
  Party? relax;
  int? total;

  Dance({this.party, this.relax, this.total});

  Dance.fromJson(Map<String, dynamic> json) {
    party = json['party'] != null ? new Party.fromJson(json['party']) : null;
    relax = json['relax'] != null ? new Party.fromJson(json['relax']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.party != null) {
      data['party'] = this.party!.toJson();
    }
    if (this.relax != null) {
      data['relax'] = this.relax!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Party {
  List<Track>? data;
  int? count;

  Party({this.data, this.count});

  Party.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Track>[];
      json['data'].forEach((v) {
        data!.add(new Track.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Track {
  String? id;
  String? name;
  String? artists;
  String? externalUrl;

  Track({this.id, this.name, this.artists, this.externalUrl});

  Track.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    artists = json['artists'];
    externalUrl = json['external_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['artists'] = this.artists;
    data['external_url'] = this.externalUrl;
    return data;
  }
}

class Mood {
  Party? depressed;
  Party? sad;
  Party? happy;
  Party? elated;
  int? total;

  Mood({this.depressed, this.sad, this.happy, this.elated, this.total});

  Mood.fromJson(Map<String, dynamic> json) {
    depressed = json['depressed'] != null
        ? new Party.fromJson(json['depressed'])
        : null;
    sad = json['sad'] != null ? new Party.fromJson(json['sad']) : null;
    happy = json['happy'] != null ? new Party.fromJson(json['happy']) : null;
    elated = json['elated'] != null ? new Party.fromJson(json['elated']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.depressed != null) {
      data['depressed'] = this.depressed!.toJson();
    }
    if (this.sad != null) {
      data['sad'] = this.sad!.toJson();
    }
    if (this.happy != null) {
      data['happy'] = this.happy!.toJson();
    }
    if (this.elated != null) {
      data['elated'] = this.elated!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Energy {
  Party? highEnergy;
  Party? chill;
  int? total;

  Energy({this.highEnergy, this.chill, this.total});

  Energy.fromJson(Map<String, dynamic> json) {
    highEnergy = json['high_energy'] != null
        ? new Party.fromJson(json['high_energy'])
        : null;
    chill = json['chill'] != null ? new Party.fromJson(json['chill']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.highEnergy != null) {
      data['high_energy'] = this.highEnergy!.toJson();
    }
    if (this.chill != null) {
      data['chill'] = this.chill!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}
