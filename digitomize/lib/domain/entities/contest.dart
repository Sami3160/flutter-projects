class ContestDuration {
  final int hours;
  final int minutes;

  ContestDuration({required this.hours, required this.minutes});

  factory ContestDuration.fromJson(Map<String, dynamic> json) {
    return ContestDuration(
      hours: json['hours'] as int? ?? 0,
      minutes: json['minutes'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'hours': hours, 'minutes': minutes};
}

class Contest {
  String? host;
  String? name;
  int? duration;
  String? platform;
  String? vanity;
  int? startTimeUnix;

  Contest({
    required this.host,
    required this.name,
    this.duration,  
    this.platform,
    required this.vanity,
    required this.startTimeUnix,
  });

  factory Contest.fromJson(Map<String, dynamic>? json) {
    return Contest(
      host: json?['host'] as String? ?? '',
      name: json?['name'] as String? ?? '',
      duration: json?['duration'] as int? ?? 0,
      platform: json?['platform'] as String?,
      vanity: json?['vanity'] as String?,
      startTimeUnix: json?['startTimeUnix'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'host': host,
    'name': name,
    'duration': duration,
    'platform': platform,
    'vanity': vanity,
    'startTimeUnix': startTimeUnix,
  };
}
