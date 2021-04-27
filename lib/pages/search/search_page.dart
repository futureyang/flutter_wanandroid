import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/pages/search/search_history_page.dart';
import 'package:flutter_wanandroid/pages/search/search_result_page.dart';
import 'package:flutter_wanandroid/router/fluro_navigator.dart';
import 'package:flutter_wanandroid/utils/event_bus_util.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  var childWidgets = <Widget>[SearchHistoryPage()];
  var searchResultPage = SearchResultPage();

  var searchEvent;

  @override
  Widget build(BuildContext context) {
    searchEvent = eventBus.on<SearchEvent>((event) {
      if (event.type == 2) {
        controller.text = event.searchValue;
        onSearch(event.searchValue, 2);
      }
    });

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: SearchBar(
        onBack: () {
          if (childWidgets.length < 2) {
            NavigatorUtils.goBack(context);
            return;
          }
          setState(() {
            childWidgets.removeLast();
          });
        },
        onSearch: (searchValue) {
          onSearch(searchValue, 3);
        },
        controller: controller,
      ),
      body: childWidgets.last,
    );
  }

  @override
  void dispose() {
    eventBus.off(searchEvent);
    super.dispose();
  }

  onSearch(String searchValue, int type) {
    if (type == 3) {
      eventBus.emit(SearchEvent(searchValue, 3));
    }
    if (childWidgets.length == 1) {
      setState(() {
        childWidgets.add(SearchResultPage(searchValue: searchValue));
      });
      return;
    }
    eventBus.emit(SearchEvent(searchValue, 1));
  }
}

class SearchEvent {
  String searchValue;
  int type; //1.点击搜索  2.热门搜索/搜索历史  3.输入框搜索

  SearchEvent(this.searchValue, this.type);
}
