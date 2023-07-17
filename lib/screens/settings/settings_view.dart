import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:service_streams_example/screens/settings/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }

      if (!controller.isSignedIn) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: controller.signIn,
              child: const Text('Sign In'),
            ),
          ],
        );
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: controller.signOut,
            child: const Text('Sign Out'),
          ),
          const SizedBox(height: 24),
          if (!controller.isPremiumMember)
            FilledButton(
              onPressed: controller.buyPremiumMembership,
              child: const Text('Buy Premium Membership'),
            )
          else
            FilledButton(
              onPressed: controller.endPremiumMembership,
              child: const Text('End Premium Membership'),
            ),
        ],
      );
    });
  }
}
