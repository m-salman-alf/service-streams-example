import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:service_streams_example/screens/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Obx(() {
        final user = controller.user;

        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (user == null) {
          return const Center(
            child: Text(
              'You are currently signed out. Head to the settings tab and sign in to continue.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              foregroundImage: NetworkImage(
                user.profilePictureUrl,
                scale: 2.0,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Hi! My name is ${user.name}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            if (user.membershipExpirationDate != null) ...[
              const Text(
                'I am a Premium Member!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ]
          ],
        );
      }),
    );
  }
}
