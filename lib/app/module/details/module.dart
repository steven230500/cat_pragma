import 'package:cat_pragma/app/module/details/presenter/page/page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailModule extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => DetailPage(breed: Modular.args.data),
      transition: TransitionType.fadeIn,
    );
  }
}
