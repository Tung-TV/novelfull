import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelfull/screens/dexuat.dart';
import 'package:novelfull/screens/truyenmoi.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> with TickerProviderStateMixin {
 
  
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        body: Column(
          children: [
            // tapbar chuyển đổi giữa đề xuất và truyện mới
            Container(
             child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
              labelPadding: const EdgeInsets.only(left: 20,right: 20),
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: CircleTabIndicatro(color: Colors.deepPurple,radius: 3),
              tabs:[
              Tab(text: "Đề xuất"),
              Tab(text: "Truyện Mới"),
              ]
              ),
              )
      ),
      Container(
        padding: const EdgeInsets.only(left: 20),
        height: 550,
        width: double.maxFinite,
        child: TabBarView(
         controller: _tabController,
        children: [
        
          DeXuat(),
          TruyenMoi(),
        ]
        ),
         )
         ]
         )
          );
  }
}
// vẽ chấm tròn dưới chân các tab khi được chọn
class CircleTabIndicatro extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicatro({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius, configuration.size!.height);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
