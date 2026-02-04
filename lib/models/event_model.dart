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
    this.eventDateDisplay,
  });

  final String? eventDateDisplay;

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
      eventDateDisplay: json['eventDateDisplay'],
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
      // Intentar parsear formato ISO 8601 primero (ej: "2026-02-23T09:30:00Z")
      try {
        return DateTime.parse(eventDate);
      } catch (e) {
        // Si falla, intentar parsear formato legible "23/02/2026 9:30 AM"
        return _parseReadableDate(eventDate);
      }
    } catch (e) {
      return DateTime.now();
    }
  }

  /// Parsea un formato legible de fecha como "23/02/2026 9:30 AM"
  DateTime _parseReadableDate(String dateStr) {
    try {
      // Remover espacios extra y normalizar
      final cleaned = dateStr.trim();
      
      // Patrón: "DD/MM/YYYY HH:MM AM/PM" o "DD/MM/YYYY HH:MM"
      final regex = RegExp(r'(\d{1,2})/(\d{1,2})/(\d{4})\s+(\d{1,2}):(\d{2})\s*(AM|PM)?', caseSensitive: false);
      final match = regex.firstMatch(cleaned);
      
      if (match != null) {
        final day = int.parse(match.group(1)!);
        final month = int.parse(match.group(2)!);
        final year = int.parse(match.group(3)!);
        var hour = int.parse(match.group(4)!);
        final minute = int.parse(match.group(5)!);
        final period = match.group(6)?.toUpperCase();
        
        // Convertir a formato 24 horas si hay AM/PM
        if (period != null) {
          if (period == 'PM' && hour != 12) {
            hour += 12;
          } else if (period == 'AM' && hour == 12) {
            hour = 0;
          }
        }
        
        return DateTime(year, month, day, hour, minute);
      }
      
      // Si no coincide con el patrón, lanzar error
      throw FormatException('Formato de fecha no reconocido: $dateStr');
    } catch (e) {
      // Si falla, retornar fecha actual
      return DateTime.now();
    }
  }

  String get formattedDate {
    try {
      final dt = eventDateTime.toLocal();
      final hour = dt.hour % 12;
      final hour12 = hour == 0 ? 12 : hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour < 12 ? 'AM' : 'PM';
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} $hour12:$minute $period';
    } catch (e) {
      return eventDate;
    }
  }

  /// Fecha para mostrar: eventDateDisplay si existe, sino formattedDate.
  String get displayDate => eventDateDisplay ?? formattedDate;
}

