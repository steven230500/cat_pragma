import 'package:cat_pragma/app/core/module.dart';
import 'package:cat_pragma/app/module/details/module.dart';
import 'package:cat_pragma/app/module/home/module.dart';
import 'package:cat_pragma/app/module/home/presenter/bloc/theme/theme_bloc.dart';
import 'package:cat_pragma/app/module/splash/module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(ThemeBloc.new);
  }

  @override
  void routes(r) {
    r.module('/', module: SplashModule());
    r.module(
      '/home',
      module: HomeModule(),
      transition: TransitionType.fadeIn,
    );
    r.module(
      '/detail',
      module: DetailModule(),
      transition: TransitionType.fadeIn,
    );
  }
}
