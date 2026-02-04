import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../models/event_model.dart';

/// Tarjeta de evento reutilizable (Eventos general y sección Información de ministerios).
class EventCard extends StatelessWidget {
  final EventModel event;
  final double screenWidth;
  final double screenHeight;

  const EventCard({
    super.key,
    required this.event,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: grisCard,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: colorWithOpacity(blanco, 0.1),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              color: colorWithOpacity(blanco, 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
            ),
            child: event.imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                    child: Image.network(
                      event.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(Icons.event_outlined, color: grisMedio, size: 48),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: accent,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Icon(Icons.event_outlined, color: grisMedio, size: 48),
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    color: blanco,
                    fontSize: screenWidth < 360 ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  event.description,
                  overflow: TextOverflow.visible,
                  style: getHeroDescription(screenWidth),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: grisMedio, size: 18),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        event.location,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: grisMedio,
                          fontSize: screenWidth < 360 ? 13 : 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenWidth * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: colorWithOpacity(blanco, 0.1),
                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                      ),
                      child: Text(
                        event.displayDate,
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: blanco,
                          fontSize: screenWidth < 360 ? 11 : 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (event.registrationLink != null && event.registrationLink!.isNotEmpty) ...[
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () async {
                      final uri = Uri.parse(event.registrationLink!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenWidth * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1),
                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.link, color: blanco, size: 18),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            'Inscripción',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              color: blanco,
                              fontSize: screenWidth < 360 ? 14 : 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
