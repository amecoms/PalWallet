import 'package:genius_wallet/config/dependency.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

//flutter packages pub run build_runner build
GetIt instance = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)

void configureInjection() {
  GetIt.I.allowReassignment = true;
  init(instance,environment: Environment.dev);
}
