import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lcf/screens/signin_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
          child: Column(children: [
        Expanded(
          child: PageView.builder(
            itemCount: demo_data.length,
            controller: _pageController,
            itemBuilder: (context, index) => OnBoardContent(
              image: demo_data[index].image,
              title: demo_data[index].title,
              description: demo_data[index].description,
            ),
          ),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: ElevatedButton(
            onPressed: () {
              _pageController.nextPage(
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
            ),
            child: Icon(Icons.arrow_forward),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const SignInScreen()));
            },
            child: Text("Skip")),
        SizedBox(
          height: 20,
        )
      ])),
    );
  }
}

class Onboard {
  final String image, title, description;
  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onboard> demo_data = [
  Onboard(
    image: "images/lcflogomini.png",
    title: "What is LCF?",
    description: "LCF is a locker reserving\n service provided in public areas",
  ),
  Onboard(
      image: "images/comfort.jpg",
      title: "Reserve a locker",
      description:
          "So you don't have to carry your belongings all day long and enjoy your day comfortably"),
  Onboard(
      image: "images/payment-illustration.jpg",
      title: "How will you Pay?",
      description:
          "You can register your Credit Card for ease of pay to make the transaction go more smoothly"),
  Onboard(
      image: "images/secure.jpg",
      title: "Is it Secure?",
      description:
          "Don't worry we ensure our lockers are perfectly sealed as maintenace and check-ups are a standard procedure of our admin's"),
  Onboard(
    image: "images/lcflogomini.png",
    title: "Thank you",
    description: "We hope you try our services in the future",
  ),
];

class OnBoardContent extends StatelessWidget {
  const OnBoardContent(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);
  final String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        Spacer(),
        Text(title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w500)),
        SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        Spacer()
      ],
    );
  }
}
