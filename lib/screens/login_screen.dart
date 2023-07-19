import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final Config config = Config(
      tenant: '0cf6c18c-d0d2-4a3f-83d0-663d620a63d3',
      clientId: 'ee9408ea-3eba-4a76-a1bc-81e1ea2d7198',
      scope: 'openid profile offline_access',
      navigatorKey: navigatorKey,
      loader: const SizedBox());

  late Future<bool> loggedin;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    loggedin = _prefs.then((SharedPreferences prefs) {
      prefs.remove("loggedin");
      return prefs.getBool('loggedin') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: loggedin,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.data == true) {
                  Future(() {
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (_) => false);
                    }
                  });
                  return const CircularProgressIndicator();
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      title: Text(
                        "login",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    body: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                          width: 300,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            elevation: 5,
                            color: Theme.of(context).colorScheme.primary,
                            child: ListTile(
                              minVerticalPadding: 10.0,
                              title: Text(
                                "hendrix today",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.launch),
                          title: Text('Login'),
                          onTap: () {
                            login();
                          },
                        ),
                      ],
                    ),
                  );
                }
              }
          }
        });
  }

  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  void showMessage(String text) {
    var alert = AlertDialog(content: Text(text), actions: <Widget>[
      TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void login() async {
    config.webUseRedirect = false;
    final AadOAuth oauth = AadOAuth(config);
    await oauth.logout();
    final result = await oauth.login();
    result.fold(
      (l) => showError(l.toString()),
      (r) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedin', true);
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
        }
      },
    );
  }
}
