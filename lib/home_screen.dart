import 'package:cometchat_flutter_sample_app/utils/custom_colors.dart';
import 'package:cometchat_flutter_sample_app/utils/strings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.whatsappColor,
          title: const Text(
            Strings.appName,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.separated(
          itemCount: 10,
          itemBuilder: (_, index) {
            return _buildChatItem();
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
        ));
  }

  Widget _buildChatItem() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: const Row(
        children: [
          CircleAvatar(),
          SizedBox(width: 19),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aron',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                'Where are you now',
                style:
                    TextStyle(color: CustomColors.messageColor, fontSize: 13),
              )
            ],
          )
        ],
      ),
    );
  }
}
