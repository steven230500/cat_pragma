import 'package:cat_pragma/app/core/module.dart';
import 'package:cat_pragma/app/module/splash/presenter/bloc/bloc.dart';
import 'package:cat_pragma/app/module/splash/presenter/page/page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(SplashBloc.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const SplashPage(),
      transition: TransitionType.fadeIn,
    );
  }
}
