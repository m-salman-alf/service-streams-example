import 'package:get/get.dart';

import 'package:service_streams_example/models/state.dart';
import 'package:service_streams_example/models/user.dart';
import 'package:service_streams_example/services/authentication_service.dart';

class HomeController extends GetxController {
  HomeController(this.authenticationService);

  final AuthenticationService authenticationService;

  User? get user => _user.value;
  final Rxn<User> _user = Rxn();

  bool get isLoading => _isLoading.value;
  final RxBool _isLoading = false.obs;

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
}
