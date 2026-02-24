import 'package:montebit/features/cards/ui/cards_page.dart';
import 'package:montebit/features/login/ui/login_page.dart';
import 'package:montebit/features/splash/models/initial_route_model.dart';
import 'package:montebit/features/splash/services/splash_services.dart';

class GetInitialRouteUsecase {
  GetInitialRouteUsecase(this._splashService);

  final SplashServices _splashService;

  Future<InitialRouteModel> call() async {
    final isLogged = await _splashService.isLogged();

    final route = isLogged ? CardsPage.route : LoginPage.route;

    return InitialRouteModel(route: route);
  }
}
