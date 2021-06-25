part of 'pages.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      body: SafeArea(
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
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 20,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Find your password again',
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 14,
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
                      onPressed: () async {
                        final email = _emailController.text;

                        if (_formKey.currentState!.validate()) {
                          showLoaderDialog(context);
                          await AuthServices.resetPassword(email);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg:
                                  'Form Password baru telah dikirim ke email anda');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: purpleColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'Forgot Password',
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
    );
  }
}
