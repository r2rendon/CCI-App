import 'package:flutter/material.dart';
import '../widgets/social_link.dart';

class IgAlive extends StatelessWidget {
  final String socialId;
  const IgAlive(this.socialId, {super.key});

  @override
  Widget build(BuildContext context) {
    return SocialLink(
      socialId: socialId,
      url: 'https://www.instagram.com/alive.cci',
      platform: 'Instagram',
    );
  }
}
