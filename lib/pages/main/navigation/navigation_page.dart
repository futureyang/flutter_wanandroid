import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/entity/banner_entity.dart' as Banner;
import 'package:flutter_wanandroid/entity/navigation_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/router/fluro_navigator.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/widgets/banner_bar.dart';
import 'package:flutter_wanandroid/widgets/overscroll_behavior.dart';
import 'package:sticky_headers/sticky_headers.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key key}) : super(key: key);

  @override
  createState() => new _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with AutomaticKeepAliveClientMixin<NavigationPage> {
  List<Banner.Banner> bannerDatas = [];
  List<Navigation> navigationList = [];
  bool isError = false;
  SwiperController _swiperController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController();
    getData();
  }

  Widget build(BuildContext context) {
    return isError
        ? errorWidget()
        : Scaffold(
            appBar: bannerDatas.length == 0
                ? null
                : BannerBar(
                    MediaQuery.of(context).size.width / 1.8 * 0.8, bannerDatas),
            body: Container(
                margin: bannerDatas.length == 0
                    ? EdgeInsets.only(top: context.statusBarHeight)
                    : EdgeInsets.only(),
                decoration: new BoxDecoration(
                  color: context.bgColorSecondary,
                ),
                child: ScrollConfiguration(
                    behavior: OverScrollBehavior(),
                    child: ListView.builder(
                      itemCount: navigationList.length,
                      shrinkWrap: true,
                      addSemanticIndexes: false,
                      itemBuilder: (_, int index) {
                        return StickyHeader(
                          header: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            color: context.backgroundColor,
                            padding: EdgeInsets.only(left: 16.0),
                            height: 34.0,
                            child: Text(navigationList[index].name),
                          ),
                          content: _buildItem(navigationList[index].articles),
                        );
                      },
                    ))),
          );
  }

  Widget errorWidget() {
    return new Scaffold(
      appBar: null,
      body: Center(
          child: GestureDetector(
        child: Container(
          width: 120,
          height: 40,
          margin: EdgeInsets.all(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: context.isDark
                  ? MyColor.bgColorThirdNight
                  : MyColor.bgColorThirdLight,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(offset: Offset(0, 1), color: context.hintColor)
              ]),
          padding: EdgeInsets.all(10.0),
          child: Text(
            "????????????",
            style: TextStyle(fontSize: 15, color: context.textColor),
          ),
        ),
        onTap: () {
          getData();
        },
      )),
    );
  }

//   Widget getBanner() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       //1.8???banner????????????0.8???viewportFraction??????
//       height: MediaQuery.of(context).size.width / 1.8 * 0.8,
//       padding: EdgeInsets.only(top: 10),
//       color: context.backgroundColor,
//       child: ScrollConfiguration(
//         behavior: OverScrollBehavior(),
//         child: Swiper(
//           itemCount: bannerDatas.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular((10.0)), // ?????????
//                 image: DecorationImage(
//                   image: NetworkImage(bannerDatas[index].imagePath),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             );
//           },
//           autoplay: true,
//           autoplayDelay: 3000,
//           //???????????????????????????
//           autoplayDisableOnInteraction: true,
//           duration: 600,
//           //??????????????????
// //        control: SwiperControl(),
//           controller: _swiperController,
//           //???????????????
//           // pagination: SwiperPagination(
//           //   // SwiperPagination.fraction ??????1/5????????????
//           //   builder: DotSwiperPaginationBuilder(size: 6, activeSize: 9),
//           // ),
//           //???????????????????????????item??????????????????
//           viewportFraction: 0.8,
//           //??????item????????????
//           scale: 0.9,
//           onTap: (int index) {
//             //???????????????????????????
//             print("index-----" + index.toString());
//           },
//         ),
//       ),
//     );
//   }

  Widget _buildItem(List<Article> articles) {
    return Container(
        decoration: new BoxDecoration(
          color: context.backgroundColor,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
        margin: EdgeInsets.only(bottom: 6),
        child: Wrap(
            spacing: 12, //???????????????????????????
            runSpacing: 10, //????????????????????????????????????
            children: List.generate(articles.length, (index) {
              return GestureDetector(
                child: Container(
                    padding:
                        EdgeInsets.only(left: 10, top: 4, right: 10, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: context.isDark
                            ? MyColor.bgColorThirdNight
                            : MyColor.bgColorThirdLight),
                    child: Text(
                      articles[index].title,
                      style: TextStyle(color: context.textColor, fontSize: 13),
                    )),
                onTap: () {
                  NavigatorUtils.goDetailPage(
                      context, articles[index].title, articles[index].link);
                },
              );
            }) //???????????????????????????
            ));
  }

  void getData() {
    DioManager.get<List<Banner.Banner>>(API.BANNER, {}, (data) {
      setState(() {
        bannerDatas = data;
      });
    }, (error) {
      Toast.show(error.errorMsg);
    });

    DioManager.get<List<Navigation>>(API.NAVI, {}, (data) {
      setState(() {
        isError = false;
        navigationList = data;
      });
    }, (error) {
      Toast.show(error.errorMsg);
      setState(() {
        isError = true;
      });
    });
  }
}
