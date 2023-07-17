import 'package:get/get.dart';

import 'package:service_streams_example/api/api.dart';
import 'package:service_streams_example/models/state.dart';
import 'package:service_streams_example/models/user.dart';

class AuthenticationService extends GetxService {
  AuthenticationService(this.api);

  final Api api;

  /// The current authentication user.
  ///
  /// **DO** use this value to set the initial value of the stream,
  /// or for one-time action (making request, button click, etc.)
  ///
  /// **DO NOT** use this value to update the UI.
  ///
  /// The value can be
  ///   - [User] when the user has signed in
  ///   - [null] when the user is signed out
  ///   - [null] when the [State] is [LoadingState]
  User? get currentUser {
    final authState = _authState.value;

    if (authState is! DataState<User?>) {
      return null;
    }

    if (authState.data == null) {
      return null;
    }

    return authState.data;
  }

  /// The authentication state.
  /// Subscribe to this value to make sure the UI is always updated.
  ///
  /// The value can be
  ///   - [LoadingState]
  ///   - [DataState] with a [User] when the user has signed in
  ///   - [DataState] with a [null] when the user is signed out
  Stream<State<User?>> get authState => _authState.stream;

  final Rx<State<User?>> _authState = Rx<State<User?>>(const LoadingState());

  /// Sign in to the app.
  Future<void> signIn() async {
    _authState.value = const LoadingState();

    final user = await api.signIn();

    _authState.value = DataState(user);
  }

  /// Sign out from the app.
  Future<void> signOut() async {
    _authState.value = const LoadingState();

    await api.signOut();

    _authState.value = const DataState(null);
  }

  /// Refreshes the current [authState] and sends a new value to the stream.
  Future<void> refreshAuthState() async {
    signIn();
  }
}
