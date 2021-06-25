part of 'pages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is AuthInitial) {
            showLoaderDialog(context);
          } else if (authState is AuthSuccess) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(authState.userResult)),
              (Route<dynamic> route) => false,
            );
          } else if (authState is AuthFailed) {
            Navigator.pop(context);
            Fluttertoast.showToast(msg: authState.messages);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    ///HEADER
                    Image.asset(
                      'assets/images/main_icon.png',
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 26,
                        color: whiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Find your Friends',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    ///FORM BODY
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email tidak boleh kosong.';
                              }

                              if (value.isNotEmpty) {
                                isEmailValid = EmailValidator.validate(value);
                                if (isEmailValid == false) {
                                  return 'Masukan email dengan benar';
                                }
                              }
                              return null;
                            },
                            style: TextStyle(color: whiteColor),
                            decoration: textFieldInputDecoration.copyWith(
                                hintText: 'Email'),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password tidak boleh kosong.';
                              }
                              return null;
                            },
                            style: TextStyle(color: whiteColor),
                            decoration: textFieldInputDecoration.copyWith(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: _obscureText
                                    ? Icon(
                                        Icons.visibility,
                                        color: purpleColor,
                                      )
                                    : Icon(Icons.visibility_off,
                                        color: purpleColor),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),

                    ///BUTTON
                    Container(
                      height: 52,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final email = _emailController.text;
                          final password = _passwordController.text;

                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                LoginRequest(email: email, password: password));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: purpleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum memiliki akun?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          child: Text(
                            'Daftar disini',
                            style: TextStyle(
                              color: purpleColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                      child: Text(
                        'Lupa Password?',
                        style: subtitleTextStyle.copyWith(
                          color: purpleColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
