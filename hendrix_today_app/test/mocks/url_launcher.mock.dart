import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

// How to mock the launchUrl() method: https://stackoverflow.com/a/74128795
class MockUrlLauncher extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {
  @override
  Future<bool> canLaunch(String s) => Future.value(true);
}

MockUrlLauncher setupMockUrlLauncher(Future<bool> Function(Invocation) func) {
  final mock = MockUrlLauncher();
  registerFallbackValue(const LaunchOptions());

  when(() => mock.launchUrl(any(), any())).thenAnswer(func);
  return mock;
}
