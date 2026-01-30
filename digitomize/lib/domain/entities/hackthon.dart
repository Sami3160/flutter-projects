class Hackthon {
  Hackthon({
    required this.host,
    required this.name,
    required this.vanity,
    required this.url,
    required this.duration,
    required this.registrationStartTimeUnix,
    required this.registrationEndTimeUnix,
    required this.hackthonStartTimeUnix,
  });
  String host;
  String name;
  String vanity;
  String url;
  int duration;
  int registrationStartTimeUnix;
  int registrationEndTimeUnix;
  int hackthonStartTimeUnix;


  factory Hackthon.fromJson(Map<String, dynamic>? json) {
    return Hackthon(
      host: json?['host'] as String,
      name: json?['name'] as String,
      vanity: json?['vanity'] as String,
      url: json?['url'] as String,
      duration: json?['duration'] as int,
      registrationStartTimeUnix: json?['registrationStartTimeUnix'] as int,
      registrationEndTimeUnix: json?['registrationEndTimeUnix'] as int,
      hackthonStartTimeUnix: json?['hackthonStartTimeUnix'] as int,
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
    'hackthonStartTimeUnix': hackthonStartTimeUnix,
  };
}