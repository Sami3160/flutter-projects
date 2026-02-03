class Hackthon {
  Hackthon({
    this.host,
    this.name,
    this.vanity,
    this.url,
    this.duration,
    this.registrationStartTimeUnix,
    this.registrationEndTimeUnix,
    this.hackathonStartTimeUnix,
  });
  String? host;
  String? name;
  String? vanity;
  String? url;
  int? duration;
  int? registrationStartTimeUnix;
  int? registrationEndTimeUnix;
  int? hackathonStartTimeUnix;

  factory Hackthon.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Hackthon();
    }
    return Hackthon(
      host: json['host']?.toString(),
      name: json['name']?.toString(),
      vanity: json['vanity']?.toString(),
      url: json['url']?.toString(),
      duration: json['duration'] != null
          ? int.tryParse(json['duration'].toString()) ?? 0
          : null,
      registrationStartTimeUnix: json['registrationStartTimeUnix'] != null
          ? int.tryParse(json['registrationStartTimeUnix'].toString()) ?? 0
          : null,
      registrationEndTimeUnix: json['registrationEndTimeUnix'] != null
          ? int.tryParse(json['registrationEndTimeUnix'].toString()) ?? 0
          : null,
      hackathonStartTimeUnix: json['hackathonStartTimeUnix'] != null
          ? int.tryParse(json['hackathonStartTimeUnix'].toString()) ?? 0
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'host': host,
    'name': name,
    'vanity': vanity,
    'url': url,
    'duration': duration,
    'registrationStartTimeUnix': registrationStartTimeUnix,
    'registrationEndTimeUnix': registrationEndTimeUnix,
    'hackathonStartTimeUnix': hackathonStartTimeUnix,
  };
}
