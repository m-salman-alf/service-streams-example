/// A model for the app's user.
class User {
  const User({
    required this.name,
    required this.profilePictureUrl,
    required this.accessToken,
    required this.membershipExpirationDate,
  });

  final String name;

  final String profilePictureUrl;

  final String accessToken;

  final DateTime? membershipExpirationDate;
}
