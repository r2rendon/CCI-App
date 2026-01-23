class EventModel {
  final String eventId;
  final String name;
  final String eventDate;
  final String imageUrl;
  final String description;
  final String? registrationLink;
  final String location;
  final String createdAt;

  EventModel({
    required this.eventId,
    required this.name,
    required this.eventDate,
    required this.imageUrl,
    required this.description,
    this.registrationLink,
    required this.location,
    required this.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['eventId'] ?? '',
      name: json['name'] ?? '',
      eventDate: json['eventDate'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      registrationLink: json['registrationLink'],
      location: json['location'] ?? 'San Pedro Sula',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'name': name,
      'eventDate': eventDate,
      'imageUrl': imageUrl,
      'description': description,
      'registrationLink': registrationLink,
      'location': location,
      'createdAt': createdAt,
    };
  }

  DateTime get eventDateTime {
    try {
      return DateTime.parse(eventDate);
    } catch (e) {
      return DateTime.now();
    }
  }

  String get formattedDate {
    try {
      final dt = eventDateTime;
      return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return eventDate;
    }
  }
}

