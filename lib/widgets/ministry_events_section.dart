import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/aws_events_service.dart';
import '../models/event_model.dart';
import 'event_card.dart';

/// Sección reutilizable "Información" con eventos por categoría (next, alive, shift).
/// Usa AWS igual que Eventos general; las notificaciones se gestionan desde el backend por categoría.
class MinistryEventsSection extends StatelessWidget {
  /// Categoría del ministerio: 'next', 'alive' o 'shift'.
  final String category;

  const MinistryEventsSection({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.02,
            bottom: screenHeight * 0.02,
          ),
          child: Text(
            'Información',
            style: getSectionTitleStyle(screenWidth),
          ),
        ),
        FutureBuilder<List<EventModel>>(
          future: AWSEventsService.getEventsForMinistry(category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
                  child: CircularProgressIndicator(color: accent),
                ),
              );
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const SizedBox.shrink();
            }
            final events = snapshot.data!;
            if (events.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: Text(
                  'No hay eventos programados.',
                  style: getBodyTextStyle(screenWidth).copyWith(color: grisMedio),
                ),
              );
            }
            return Column(
              children: events
                  .map((e) => Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: EventCard(
                          event: e,
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
