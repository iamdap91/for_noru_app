import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:for_noru_app/components/percentage-indicator.component.dart';
import 'package:for_noru_app/components/shimmers/content-detail-shimmer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/vote-type.dart';
import '../stores/content.store.dart';
import 'gallery.component.dart';

class ContentDetail extends StatefulWidget {
  final String id;

  ContentDetail({Key? key, required String this.id}) : super(key: key);

  @override
  State<ContentDetail> createState() => _ContentDetailState();
}

class _ContentDetailState extends State<ContentDetail> {
  @override
  void initState() {
    super.initState();
    context.read<ContentStore>().findOne(id: widget.id);
    context.read<ContentStore>().findVotes(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<ContentStore>().placeInfo == null ||
        context.watch<ContentStore>().percentages == null) {
      return ContentDetailShimmer();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text(
          context.watch<ContentStore>().placeInfo['name'],
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            context.watch<ContentStore>().placeInfo['images'].length == 0
                ? Image.asset(
                    'assets/eraser.png',
                    height: 400,
                  )
                : CarouselSlider.builder(
                    itemCount: context
                        .watch<ContentStore>()
                        .placeInfo['images']
                        .length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Gallery(
                                images: context
                                    .watch<ContentStore>()
                                    .placeInfo['images']
                                    ?.cast<String>(),
                                initialPage: pageViewIndex,
                              );
                            }),
                          );
                        },
                        child: Hero(
                          tag: '$itemIndex',
                          child: context
                                      .watch<ContentStore>()
                                      .placeInfo['images']
                                      .length >
                                  0
                              ? Image.network(context
                                  .watch<ContentStore>()
                                  .placeInfo['images'][itemIndex])
                              : Image.asset('assets/eraser.png'),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      height: 400,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                    ),
                    carouselController: CarouselController(),
                  ),
            Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:
                      context.watch<ContentStore>().placeInfo['phone'] != null
                          ? () {
                              launchUrl(Uri.parse(
                                  'tel://${context.watch<ContentStore>().placeInfo['phone']}'));
                            }
                          : null,
                  child: Row(children: [
                    Icon(Icons.phone, color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('전화', style: TextStyle(color: Colors.black)),
                    )
                  ]),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!await launchUrl(Uri.parse(
                        context.watch<ContentStore>().placeInfo['mapUrl']))) {
                      throw 'Could not launch ${context.watch<ContentStore>().placeInfo['mapUrl']}';
                    }
                  },
                  child: Row(children: [
                    Icon(Icons.map, color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('지도', style: TextStyle(color: Colors.black)),
                    )
                  ]),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(
                            text: context
                                .watch<ContentStore>()
                                .placeInfo['address']))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('주소가 복사되었어요!'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    });
                  },
                  child: Row(children: [
                    Icon(Icons.copy, color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text('주소 복사', style: TextStyle(color: Colors.black)),
                    )
                  ]),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            Divider(height: 20),
            PercentageIndicator(
              id: context.watch<ContentStore>().placeInfo['id'],
              text: '소형견 입장이 가능해요',
              percentage:
                  context.watch<ContentStore>().percentages[0].toDouble(),
              voteType: VOTE_TYPE.SMALL,
            ),
            PercentageIndicator(
              id: context.watch<ContentStore>().placeInfo['id'],
              text: '중형견 입장이 가능해요',
              percentage:
                  context.watch<ContentStore>().percentages[1].toDouble(),
              voteType: VOTE_TYPE.MIDDLE,
            ),
            PercentageIndicator(
              id: context.watch<ContentStore>().placeInfo['id'],
              text: '대형견 입장이 가능해요',
              percentage:
                  context.watch<ContentStore>().percentages[2].toDouble(),
              voteType: VOTE_TYPE.BIG,
            ),
            PercentageIndicator(
              id: context.watch<ContentStore>().placeInfo['id'],
              text: '반려견의 크기/무게별 칸이 나뉘어 있어요',
              percentage:
                  context.watch<ContentStore>().percentages[3].toDouble(),
              voteType: VOTE_TYPE.SEPARATED,
            ),
          ],
        ),
      ),
    );
  }
}
