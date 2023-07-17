import 'package:service_streams_example/models/user.dart';

/// Some backend or third party service.
class Api {
  DateTime? _membershipExpirationDate;

  Future<User> signIn() async {
    // Fake delay to simulate network.
    await Future.delayed(const Duration(seconds: 2));

    return User(
      name: 'Salman',
      accessToken: 'asdfghjkl',
      profilePictureUrl:
          'https://toco-img.azureedge.net/staging/assets/tapi_4c5b97a6c0.jpeg',
      membershipExpirationDate: _membershipExpirationDate,
    );
  }

  Future<void> signOut() async {
    // Sign out logic....
  }

  Future<void> buyMembership(String token) async {
    _membershipExpirationDate = DateTime.now().add(const Duration(seconds: 30));
  }

  Future<void> endMembership(String token) async {
    _membershipExpirationDate = null;
  }
}
