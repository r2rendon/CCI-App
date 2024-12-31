import 'package:flutter/material.dart';
import '../widgets/social_link.dart';

class IgMujeres extends StatelessWidget {
  final String socialId;
  const IgMujeres(this.socialId, {super.key});

  @override
  Widget build(BuildContext context) {
    return SocialLink(
      socialId: socialId,
      url: 'https://www.instagram.com/mujeresenaccioncci',
      platform: 'Instagram',
    );
  }
}
