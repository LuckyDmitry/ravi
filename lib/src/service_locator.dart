import 'package:get_it/get_it.dart';
import 'package:ravi/src/auth/auth_service.dart';
import 'package:ravi/src/courses/data/course_repository.dart';

final GetIt services = GetIt.instance;

Future<void> servicesInit() async {
  await services.reset();

  services.registerSingleton(AuthService());
  services.registerFactory(() => CourseRepository());
  
}