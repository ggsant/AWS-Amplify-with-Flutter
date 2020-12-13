import 'package:aws_flutter/services/cameraFlow.dart';
import 'package:flutter/material.dart';

import 'screens/loginPage.dart';
import 'screens/signUpPage.dart';
import 'services/authService.dart';
import 'services/verificationPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = AuthService();

  /*
  * Para garantir que o stream tenha dados desde o início, emita um valor imediatamente. Podemos conseguir isso enviando AuthFlowStatus.login quando _MyAppState é inicializado.
  */

  @override
  void initState() {
    super.initState();
    _authService.showLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      debugShowCheckedModeBanner: false,
      /*
      * Quebramos o navegador com um StreamBuilder que espera observar um stream que emite AuthState.
      */
      home: StreamBuilder<AuthState>(
          /*
          * Acessamos o stream AuthState no authStateController a partir da instância de AuthService.
          */
          stream: _authService.authStateController.stream,
          builder: (context, snapshot) {
            /*
            * O stream pode ou não ter dados. Para acessar com segurança authFlowStatus a partir de dados, que são do tipo AuthState, implementamos devemos confirir aqui primeiro
            */
            if (snapshot.hasData) {
              return Navigator(
                pages: [
                  //Se o stream emitir AuthFlowStatus.login, mostraremos LoginPage.
                  // Show Login Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                    MaterialPage(
                      child: LoginPage(
                        didProvideCredentials:
                            _authService.loginWithCredentials,
                        shouldShowSignUp: _authService.showSignUp,
                      ),
                    ),

                  // Se o stream emitir AuthFlowStatus.signUp, mostraremos SignUpPage.

                  // Show Sign Up Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                    MaterialPage(
                      child: SignUpPage(
                        didProvideCredentials:
                            _authService.signUpWithCredentials,
                        shouldShowLogin: _authService.showLogin,
                      ),
                    ),

                  if (snapshot.data.authFlowStatus ==
                      AuthFlowStatus.verification)
                    MaterialPage(
                      child: VerificationPage(
                          didProvideVerificationCode: _authService.verifyCode),
                    ),
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                    MaterialPage(
                        child: CameraFlow(shouldLogOut: _authService.logOut))
                ],
                onPopPage: (route, result) => route.didPop(result),
              );
            } else {
              // Se o stream não tiver dados, um CircularProgressIndicator será exibido.
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
