import 'package:aws_flutter/services/authCredentials.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged<SignUpCredentials> didProvideCredentials;
  final VoidCallback shouldShowLogin;

  SignUpPage({Key key, this.didProvideCredentials, this.shouldShowLogin})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(92, 225, 230, 255),
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              Image.asset(
                'assets/logo.png',
                height: 200,
              ),
              _signUpForm(),
              Container(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  onPressed: widget.shouldShowLogin,
                  child: Text(
                    'Already have an account? Login.',
                    style: TextStyle(
                      color: Color.fromRGBO(92, 225, 230, 1),
                    ),
                  ),
                ),
              )
            ]),
          )),
    );
  }

  Widget _signUpForm() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Color.fromRGBO(92, 225, 230, 1),
                ),
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(92, 225, 230, 1),
                ),
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.mail,
                  color: Color.fromRGBO(92, 225, 230, 1),
                ),
                labelText: 'Email',
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
            SizedBox(height: 20),
            FlatButton(
              onPressed: _signUp,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Color.fromRGBO(92, 225, 230, 1),
            )
          ],
        ),
      ),
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('email: $email');
    print('password: $password');

    final credentials =
        SignUpCredentials(username: username, email: email, password: password);
    widget.didProvideCredentials(credentials);
  }
}
