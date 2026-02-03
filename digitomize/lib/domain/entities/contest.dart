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
  String? url;
  int? startTimeUnix;

  Contest({
    required this.host,
    required this.name,
    this.duration,
    this.platform,
    required this.vanity,
    this.url,
    required this.startTimeUnix,
  });

  factory Contest.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Contest(host: '', name: '', vanity: '', url: '', startTimeUnix: 0);
    }
    return Contest(
      host: (json['host'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      duration: int.tryParse(json['duration']?.toString() ?? '') ?? 0,
      platform: json['platform']?.toString() ?? '',
      vanity: json['vanity']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      startTimeUnix: int.tryParse(json['startTimeUnix']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'host': host,
    'name': name,
    'duration': duration,
    'platform': platform,
    'vanity': vanity,
    'url': url,
    'startTimeUnix': startTimeUnix,
  };
}
