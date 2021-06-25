part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _twoPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final RegExp rexUppercase = RegExp("(?:[^A-Z]*[A-Z]){1}");
  final RegExp rexLowercase = RegExp("(?:[^a-z]*[a-z]){1}");
  final RegExp rexNumber = RegExp("(?:[^0-9]*[0-9]){1}");

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
            Fluttertoast.showToast(msg: 'Registrasi Berhasil');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
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
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: 20,
                        color: whiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Let\'s join us',
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
                            controller: _nameController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama tidak boleh kosong.';
                              }

                              if (value.length < 3) {
                                return 'Nama minimal 3 huruf';
                              }

                              if (value.length > 50) {
                                return 'Nama maximal 50 huruf';
                              }

                              return null;
                            },
                            style: TextStyle(color: whiteColor),
                            decoration: textFieldInputDecoration.copyWith(
                                hintText: 'Nama'),
                          ),
                          SizedBox(
                            height: 12,
                          ),
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
                              bool checkUppercase = false;
                              bool checklowercase = false;
                              bool checkNumber = false;

                              if (value!.isEmpty) {
                                return 'Password tidak boleh kosong.';
                              }

                              if (value.length < 8) {
                                return 'Password minimal 8 karakter.';
                              }

                              if (value.isNotEmpty) {
                                checkUppercase = rexUppercase.hasMatch(value);
                                checklowercase = rexLowercase.hasMatch(value);
                                checkNumber = rexNumber.hasMatch(value);
                                if (checkUppercase == false ||
                                    checklowercase == false) {
                                  return 'Password harus Mengandung huruf besar dan kecil';
                                }

                                if (checkNumber == false) {
                                  return 'Password harus Mengandung angka';
                                }
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
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: _twoPasswordController,
                            obscureText: _obscureText,
                            validator: (value) {
                              bool checkUppercase = false;
                              bool checklowercase = false;
                              bool checkNumber = false;

                              if (value!.isEmpty) {
                                return 'Password tidak boleh kosong.';
                              }

                              if (value.length < 8) {
                                return 'Password minimal 8 karakter.';
                              }

                              if (value.isNotEmpty) {
                                checkUppercase = rexUppercase.hasMatch(value);
                                checklowercase = rexLowercase.hasMatch(value);
                                checkNumber = rexNumber.hasMatch(value);
                                if (checkUppercase == false ||
                                    checklowercase == false) {
                                  return 'Password harus Mengandung huruf besar dan kecil';
                                }

                                if (checkNumber == false) {
                                  return 'Password harus Mengandung angka';
                                }
                              }

                              return null;
                            },
                            style: TextStyle(color: whiteColor),
                            decoration: textFieldInputDecoration.copyWith(
                              hintText: 'Confirm Password',
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
                          final name = _nameController.text;
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          final twoPassword = _twoPasswordController.text;

                          if (_formKey.currentState!.validate()) {
                            if (password.contains(twoPassword)) {
                              context.read<AuthBloc>().add(RegisterRequest(
                                  name: name,
                                  email: email,
                                  password: password));
                            } else {
                              Fluttertoast.showToast(
                                msg:
                                    'Pastikan anda memasukan password yang sama.',
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: purpleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Registration',
                          style: TextStyle(
                            fontSize: 16,
                          ),
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
