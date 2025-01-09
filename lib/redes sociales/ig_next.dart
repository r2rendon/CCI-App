import 'package:flutter/material.dart';
// import '../widgets/social_link.dart';
import '../utils/social_link.dart';

class IgNext extends StatelessWidget {
  final String socialId;
  const IgNext(this.socialId, {super.key});

  @override
  Widget build(BuildContext context) {
    return SocialLink(
      socialId: socialId,
      url: 'https://www.instagram.com/next.cci',
      platform: 'Instagram',
    );
  }
}
