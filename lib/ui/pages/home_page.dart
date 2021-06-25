part of 'pages.dart';

class HomePage extends StatelessWidget {
  final UserData user;

  HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/main_icon.png',
                    height: 200,
                    width: 200,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hello ',
                        style: titleTextStyle.copyWith(
                          color: purpleColor,
                          fontSize: 24,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          user.name ?? '-',
                          style: titleTextStyle.copyWith(
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    user.email ?? '-',
                    style: subtitleTextStyle,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Builder(
                    builder: (_) {
                      bool user = AuthServices.checkVerifyUser();

                      return Text(
                        (user)
                            ? 'Your account has been Verified'
                            : 'Your account is not verified',
                        textAlign: TextAlign.center,
                        style: titleTextStyle.copyWith(fontSize: 24),
                      );
                    },
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
