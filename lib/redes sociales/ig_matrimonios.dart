import 'package:flutter/material.dart';
import '../widgets/social_link.dart';

class IgMatrimonios extends StatelessWidget {
  final String socialId;
  const IgMatrimonios(this.socialId, {super.key});

  @override
  Widget build(BuildContext context) {
    return SocialLink(
      socialId: socialId,
      url: 'https://www.instagram.com/matrimonioscci',
      platform: 'Instagram',
    );
  }
}
