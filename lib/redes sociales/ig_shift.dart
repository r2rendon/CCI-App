import 'package:flutter/material.dart';
import '../utils/social_link.dart';
// import '../widgets/social_link.dart';

class IgShift extends StatelessWidget {
  final String socialId;
  const IgShift(this.socialId, {super.key});

  @override
  Widget build(BuildContext context) {
    return SocialLink(
      socialId: socialId,
      url: 'https://www.instagram.com/shift.cci',
      platform: 'Instagram',
    );
  }
}
