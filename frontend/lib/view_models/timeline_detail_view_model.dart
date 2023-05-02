
import 'package:flutter/material.dart';

import '../models/TimelineDetail.dart';
import '../services/timeline_repository.dart';

import '../models/Post.dart';
import '../models/TimelineInfo.dart';

List<TimelineDetail> test2 = [
  TimelineDetail(flag: "flag", nation: "Seoul", postList: [
    Post(postId: 1, voiceUrl: "", voiceLength: 0, address: "서울", text: "테스트", photoList: ["https://t1.daumcdn.net/cfile/tistory/99128B3E5AD978AF20",], isFavorite: false, favoriteCount: 0)
  ], startDate: "2023-04-01", finishDate: "2023-05-01"),
  TimelineDetail(flag: "flag", nation: "Seoul", postList: [], startDate: "2023-03-01", finishDate: "2023-04-01")

];

List<TimelineInfo> test1 = [
  TimelineInfo(timelineDetails: test2, isPublic: true, isComplete: true, isMine: true),
];


class TimelineDetailViewModel extends ChangeNotifier {
  final int timelineId;
  bool _isMine = false;
  bool _isPublic = false;
  bool _isComplete = false;
  String? _title;
  final int expansionTileAnimationTile = 200;
  final textController = TextEditingController();
  List<TimelineDetail> _timelineDetails = [];

  String? get title => _title;

  get isMine => _isMine;

  get isPublic => _isPublic;

  get isComplete => _isComplete;

  get timelineDetails => _timelineDetails;

  changeTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  TimelineDetailViewModel(BuildContext context, this.timelineId) {
    loadTimelineDetails(context);
    notifyListeners();
  }

  loadTimelineDetails(context) async {
    // 주석 해제  현재 테스트 상태
    // final timelineInfo = await TimelineRepository()
    //     .getTimelineDetailsByTimelineId(context, timelineId);
    final timelineInfo = test1[0];
    _timelineDetails = timelineInfo.timelineDetails;
    _isMine = timelineInfo.isMine;
    _isPublic = timelineInfo.isPublic;
    _isComplete = timelineInfo.isComplete;
    notifyListeners();
  }

  changeExpansions(int timelineIndex, bool isExpand) async {
    if (!isExpand) {
      await Future.delayed(Duration(milliseconds: expansionTileAnimationTile));
      for (var post in _timelineDetails[timelineIndex].postList) {
        post.isExpand = false;
      }
    }
    _timelineDetails[timelineIndex].isExpand = isExpand;
    notifyListeners();
  }

  changePostExpansion(
      context, int timelineIndex, int postIndex, bool isExpand) async {
    if (!isExpand) {
      await Future.delayed(Duration(milliseconds: expansionTileAnimationTile));
    } else {
      _scrollToSelectedContent(context);
    }
    _timelineDetails[timelineIndex].postList[postIndex].isExpand = isExpand;
    notifyListeners();
  }

  void _scrollToSelectedContent(context) {
    if (context != null) {
      Future.delayed(Duration(milliseconds: expansionTileAnimationTile))
          .then((value) {
        Scrollable.ensureVisible(context,
            duration: Duration(milliseconds: expansionTileAnimationTile));
      });
    }
  }

  changeIsPublic(BuildContext context) async {
    _isPublic =
        await TimelineRepository().changeTimelinePublic(context, timelineId);
    notifyListeners();
  }

  showPublicIcon() {
    if (_isMine) {
      if (!_isPublic) {
        return const Icon(Icons.lock);
      } else {
        return const Icon(Icons.lock_open);
      }
    }
    return Container();
  }

  resetTitle() {
    changeTitle('');
    notifyListeners();
  }

  endTimeline(context) async {
    await TimelineRepository().endTravel(context, timelineId, _title!);
    Navigator.popAndPushNamed(context, '/timeline/detail/$timelineId');
  }

  deleteTimeline(context) async {
    await TimelineRepository().deleteTimeline(context, timelineId);
    Navigator.pop(context);
  }
}