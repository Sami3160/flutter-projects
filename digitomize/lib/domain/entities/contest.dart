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
  String title;
  String description;
  ContestDuration? duration;
  String? platform;
  String end;
  String start;

  Contest({
    required this.title,
    required this.description,
    this.duration,
    this.platform,
    required this.end,
    required this.start,
  });

  factory Contest.fromJson(Map<String, dynamic>? json) {
    return Contest(
      title: json?['title'] as String? ?? '',
      description: json?['description'] as String? ?? '',
      duration: json?['duration'] != null
          ? ContestDuration.fromJson(json?['duration'] as Map<String, dynamic>)
          : null,
      platform: json?['platform'] as String?,
      end: json?['end'] as String? ?? '',
      start: json?['start'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'duration': duration?.toJson(),
    'platform': platform,
    'end': end,
    'start': start,
  };
}
