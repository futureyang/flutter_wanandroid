import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/hotword_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/pages/search/search_page.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/utils/event_bus_util.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';
import 'package:flutter_wanandroid/widgets/overscroll_behavior.dart';

class SearchHistoryPage extends StatefulWidget {
  @override
  createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  var hotWordList = <HotWord>[];
  var searchHistoryList = <String>[];

  var searchEvent;

  @override
  void initState() {
    super.initState();
    _getHotSearch();
  }

  @override
  Widget build(BuildContext context) {
    searchEvent = eventBus.on<SearchEvent>((event) {
      if (event.type == 1) return;
      _addSearchHistory(event.searchValue);
    });
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 15),
                child: Text(
                  '热门搜索',
                  style: TextStyle(color: context.textColor, fontSize: 15),
                ),
              ),
              Wrap(
                  spacing: 12, //主轴上子控件的间距
                  runSpacing: 10, //交叉轴上子控件之间的间距
                  children: List.generate(hotWordList.length, (index) {
                    return GestureDetector(
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 10, top: 4, right: 10, bottom: 4),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: context.isDark
                                  ? MyColor.bgColorThirdNight
                                  : MyColor.bgColorThirdLight),
                          child: Text(
                            hotWordList[index].name,
                            style: TextStyle(
                                color: context.textColor, fontSize: 13),
                          )),
                      onTap: () {
                        _addSearchHistory(hotWordList[index].name);
                        eventBus.emit(SearchEvent(hotWordList[index].name, 2));
                      },
                    );
                  }) //要显示的子控件集合
                  ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text(
                  '搜索历史',
                  style: TextStyle(color: context.textColor, fontSize: 15),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchHistoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _searchHistoryItem(index);
                  }),
            ],
          ),
        ));
  }

  _searchHistoryItem(int index) {
    return Container(
      margin: EdgeInsets.only(left: 5, top: 15, right: 5),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.access_time, color: context.textColor, size: 16),
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 5),
                    child: Text(
                      searchHistoryList[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: context.textColor, fontSize: 14),
                    ),
                  ),
                  onTap: () {
                    _addSearchHistory(searchHistoryList[index]);
                    eventBus.emit(SearchEvent(searchHistoryList[index], 2));
                  },
                ),
              ),
              GestureDetector(
                child: Icon(
                  Icons.delete_forever,
                  color: context.textColor,
                  size: 20,
                ),
                onTap: () {
                  _deleteSearchHistory(searchHistoryList[index]);
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                color: context.isDark
                    ? MyColor.bgColorSecondaryNight
                    : MyColor.bgColorSecondaryLight,
                height: 1.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  _getHotSearch() async {
    DioManager.get<List<HotWord>>(API.HOT_KEY, {}, (data) {
      hotWordList = data;
      _getSearchHistory();
    }, (error) {
      Toast.show(error.errorMsg);
    });
  }

  _getSearchHistory() {
    searchHistoryList.addAll(SpUtil.getStringList("searchHistory"));
    setState(() {});
  }

  _addSearchHistory(String searchValue) {
    if (searchHistoryList.contains(searchValue)) {
      searchHistoryList.remove(searchValue);
      if (searchHistoryList.length > 10) {
        searchHistoryList.removeLast();
      }
    }
    searchHistoryList.insert(0, searchValue);
    setState(() {});
    SpUtil.putStringList("searchHistory", searchHistoryList);
  }

  _deleteSearchHistory(String searchValue) {
    if (searchHistoryList.contains(searchValue)) {
      setState(() {
        searchHistoryList.remove(searchValue);
      });
      SpUtil.putStringList("searchHistory", searchHistoryList);
    }
  }

  @override
  void dispose() {
    eventBus.off(searchEvent);
    super.dispose();
  }
}
