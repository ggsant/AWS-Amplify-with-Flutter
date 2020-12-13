import 'package:aws_flutter/services/authCredentials.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<LoginCredentials> didProvideCredentials;
  final VoidCallback shouldShowSignUp;

  LoginPage({Key key, this.didProvideCredentials, this.shouldShowSignUp})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(92, 225, 230, 255),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Image.asset(
                'assets/logo.png',
                height: 200,
              ),
              _loginForm(),
              Container(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  onPressed: widget.shouldShowSignUp,
                  child: Text(
                    'Don\'t have an account? Sign up.',
                    style: TextStyle(
                      color: Color.fromRGBO(92, 225, 230, 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.mail,
                  color: Color.fromRGBO(92, 225, 230, 1),
                ),
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(92, 225, 230, 1),
                ),
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_open,
                  color: Color.fromRGBO(92, 225, 230, 1),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(92, 225, 230, 1),
                ),
              ),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 30),
            FlatButton(
              onPressed: _login,
              child: Text('Login', style: TextStyle(color: Colors.white)),
              color: Color.fromRGBO(92, 225, 230, 1),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('password: $password');

    final credentials =
        LoginCredentials(username: username, password: password);
    widget.didProvideCredentials(credentials);
  }
}
