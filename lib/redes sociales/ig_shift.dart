import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/social_link.dart';
// import '../widgets/social_link.dart';

class IgShift extends ConsumerWidget {
  final String socialId;
  const IgShift(this.socialId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SocialLink(
      socialId: socialId,
      url: 'https://www.instagram.com/shift.cci',
      platform: 'Instagram',
    );
  }
}
