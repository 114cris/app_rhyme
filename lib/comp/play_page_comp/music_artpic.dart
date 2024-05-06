import 'dart:io';

import 'package:app_rhyme/util/default.dart';
import 'package:app_rhyme/util/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class MusicArtPic extends StatefulWidget {
  final EdgeInsets padding;
  const MusicArtPic({
    super.key,
    required this.padding,
  }); // 修改构造函数

  @override
  State<StatefulWidget> createState() => MusicArtPicState();
}

class MusicArtPicState extends State<MusicArtPic> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => FutureBuilder<Hero>(
        future: playingMusicImage(), // 这里调用异步函数
        builder: (BuildContext context, AsyncSnapshot<Hero> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError) {
            return Container(
                padding: widget.padding,
                child: GlassContainer(
                  shadowColor: Platform.isIOS
                      ? CupertinoColors.black.withOpacity(0.2)
                      : CupertinoColors.black.withOpacity(0.4),
                  shadowStrength: Platform.isIOS ? 3 : 8,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(18.0),
                  child: defaultArtPic,
                ) // 异步函数提供的图片或默认图片
                );
          } else {
            // 使用Cupertino组件包裹图片，并限制大小和加圆角边框
            return Container(
                padding: widget.padding,
                child: GlassContainer(
                  shadowColor: Platform.isIOS
                      ? CupertinoColors.black.withOpacity(0.2)
                      : CupertinoColors.black.withOpacity(0.4),
                  shadowStrength: Platform.isIOS ? 3 : 8,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(18.0),
                  child: snapshot.data ?? defaultArtPic,
                ));
          }
        },
      ),
    ));
  }
}
