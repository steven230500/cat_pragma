import 'package:cat_pragma/app/core/module.dart';
import 'package:cat_pragma/app/module/home/presenter/bloc/home/home_bloc.dart';
import 'package:cat_pragma/app/module/home/presenter/page/page.dart';
import 'package:cat_pragma/app/module/home/repository/repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(HomeRepository.new);
    i.addLazySingleton(HomeBloc.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const HomePage(),
      transition: TransitionType.fadeIn,
    );
  }
}
