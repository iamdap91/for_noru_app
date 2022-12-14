import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Guide extends StatefulWidget {
  const Guide({Key? key}) : super(key: key);

  @override
  GuideState createState() => GuideState();
}

class GuideState extends State<Guide> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: '검색 필터',
        description: '목록에서 필터를 통해 우리 아이와 같이 갈 수 있는 장소들을 검색해보세요!',
        pathImage: 'assets/eraser.png',
        // backgroundColor: Color(0xfff5a623),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: '투표',
        description: '투표를 통해 앱을 개선할 수 있어요!',
        pathImage: 'assets/pencil.png',
        // backgroundColor: Color(0xff203152),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: 'READY TO GO',
        pathImage: 'assets/ruler.png',
        description: '우측 상단의 버튼을 통해 안내를 다시 보실 수 있어요!',
        // backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  Future<void> onDonePress() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setBool('seenTutorial', true);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: onDonePress,
    );
  }
}
