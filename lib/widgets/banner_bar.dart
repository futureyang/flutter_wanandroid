import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wanandroid/entity/banner_entity.dart' as Banner;
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/widgets/overscroll_behavior.dart';

class BannerBar extends StatelessWidget implements PreferredSizeWidget {
  double height;

  SwiperController _swiperController;

  List<Banner.Banner> bannerDatas;

  BannerBar(this.height, this.bannerDatas, {Key key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(this.height);

  @override
  Widget build(BuildContext context) {
    _swiperController = SwiperController();
    return SafeArea(
      bottom: false,
      child: Container(
        width: MediaQuery.of(context).size.width,
        //1.8是banner宽高比，0.8是viewportFraction的值
        height: MediaQuery.of(context).size.width / 1.8 * 0.8,
        padding: EdgeInsets.only(top: 10),
        color: context.backgroundColor,
        child: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: Swiper(
            itemCount: bannerDatas.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular((10.0)), // 圆角度
                  image: DecorationImage(
                    image: NetworkImage(bannerDatas[index].imagePath),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            autoplay: true,
            autoplayDelay: 3000,
            //触发时是否停止播放
            autoplayDisableOnInteraction: true,
            duration: 600,
            //默认分页按钮
//        control: SwiperControl(),
            controller: _swiperController,
            //默认指示器
            // pagination: SwiperPagination(
            //   // SwiperPagination.fraction 数字1/5，默认点
            //   builder: DotSwiperPaginationBuilder(size: 6, activeSize: 9),
            // ),
            //视图宽度，即显示的item的宽度屏占比
            viewportFraction: 0.8,
            //两侧item的缩放比
            scale: 0.9,
            onTap: (int index) {
              //点击事件，返回下标
              print("index-----" + index.toString());
            },
          ),
        ),
      ),
    );
  }
}
