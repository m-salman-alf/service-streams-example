import 'package:get/get.dart';

import 'package:service_streams_example/api/api.dart';
import 'package:service_streams_example/models/state.dart';
import 'package:service_streams_example/models/user.dart';
import 'package:service_streams_example/services/authentication_service.dart';

class SettingsController extends GetxController {
  SettingsController(this.authenticationService, this.api);

  final AuthenticationService authenticationService;
  final Api api;

  final Rxn<User> _user = Rxn();

  bool get isLoading => _isLoading.value;
  final RxBool _isLoading = false.obs;

  bool get isSignedIn => _user.value != null;

  bool get isPremiumMember => _user.value?.membershipExpirationDate != null;

  @override
  void onInit() {
    super.onInit();

    /// Use [bindStream] to listen to [authenticationService.authState]
    ///
    /// If you need to fetch a value from the [Api] based on a Stream,
    /// you can use [asyncMap] which will return a Future.
    _user.bindStream(authenticationService.authState.map(
      (authState) {
        /// If [authState] is loading return null.
        if (authState is! DataState<User?>) {
          return null;
        }

        return authState.data;
      },
    ));

    _isLoading.bindStream(authenticationService.authState.map(
      (authState) {
        /// If [authState] is loading return true.
        if (authState is! DataState<User?>) {
          return true;
        }

        return false;
      },
    ));
  }

  void buyPremiumMembership() async {
    /// You can use [authenticationService.currentUser] here so
    /// we can get the latest value to make the request.
    final accessToken = authenticationService.currentUser?.accessToken;

    /// Handle errors here.
    if (accessToken == null) return;

    await api.buyMembership(accessToken);

    /// Don't forget to call [authenticationService.refreshAuthState]
    /// to update the UI with new [User] value.
    return authenticationService.refreshAuthState();
  }

  void endPremiumMembership() async {
    /// You can use [authenticationService.currentUser] here so
    /// we can get the latest value to make the request.
    final accessToken = authenticationService.currentUser?.accessToken;

    /// Handle errors here.
    if (accessToken == null) return;

    await api.endMembership(accessToken);

    /// Don't forget to call [authenticationService.refreshAuthState]
    /// to update the UI with new [User] value.
    return authenticationService.refreshAuthState();
  }

  /// Proxy method for [authenticationService.signIn].
  ///
  /// You can call [authenticationService] directly from the UI,
  /// but I like having the only import being the controller.
  void signIn() async {
    return authenticationService.signIn();
  }

  /// Proxy method for [authenticationService.signOut].
  ///
  /// You can call [authenticationService] directly from the UI,
  /// but I like having the only import being the controller.
  void signOut() async {
    return authenticationService.signOut();
  }
}
