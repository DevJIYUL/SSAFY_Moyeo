import 'package:camera/camera.dart';
import 'package:danim/view_models/record_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/app_view_model.dart';
import './record_screen.dart';
import '../module/my_alert_dialog.dart';
import '../view_models/camera_view_model.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider.of로 viewModel 지정
    final viewModel = Provider.of<CameraViewModel>(context, listen: false);
    return Consumer<AppViewModel>(builder: (context, appViewModel, _) {
      final screenSize = MediaQuery.of(context).size;
      return WillPopScope(
        onWillPop: () async {
          appViewModel.changeTitleToFormer();
          return true;
        },
        child: Scaffold(
          // FutureBuilder를 사용할 필요가 있는지 검토
          body: FutureBuilder(
            future: viewModel.initializeCamera(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to initialize camera: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return LayoutBuilder(
                      builder: (context, BoxConstraints constraints) {
                    return SafeArea(
                      child: Consumer<CameraViewModel>(
                          builder: (context, cameraViewModel, child) {
                        return Scaffold(
                          body: Container(
                            color: Colors.black54,
                            width: double.infinity,
                            height: double.infinity,
                            child: Stack(
                              children: [
                                // 카메라 화면
                                SizedBox(
                                  width: screenSize.width,
                                  height: screenSize.height,
                                  child: cameraViewModel.isTaking
                                      ? Container(
                                          color: Colors.black87,
                                        )
                                      : AspectRatio(
                                          aspectRatio: cameraViewModel
                                              .controller.value.aspectRatio,
                                          child: CameraPreview(
                                              cameraViewModel.controller)),
                                ),

                                // 버튼들
                                Positioned(
                                  // 위치 지정
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 160,
                                    color: Colors.black38,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 25.0),
                                              width: 55,
                                              height: 55,
                                              decoration: BoxDecoration(
                                                color: Colors.black54,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  cameraViewModel
                                                      .changeCamera();
                                                },
                                                icon: const Icon(
                                                    Icons.change_circle),
                                                color: Colors.white,
                                              ),
                                            ),
                                            Container(
                                                width: 90,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45)),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.camera,
                                                    color: Colors.white,
                                                    size: 70,
                                                  ),
                                                  onPressed: () {
                                                    if (viewModel.allFileList
                                                            .length <
                                                        9) {
                                                      viewModel.takePhoto();
                                                    } else {
                                                      OneButtonMaterialDialog()
                                                          .showFeedBack(context,
                                                              "이미지는 \n최대 9장까지 \n등록 가능합니다.");
                                                    }
                                                  },
                                                )),
                                            Consumer<AppViewModel>(
                                                builder: (_, appViewModel, __) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    right: 25.0),
                                                width: 55,
                                                height: 55,
                                                decoration: BoxDecoration(
                                                  color: Colors.black54,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                // 녹음 화면으로 이동하는 버튼
                                                child: IconButton(
                                                  icon: const Icon(Icons.folder,
                                                      color: Colors.white),
                                                  onPressed: () {
                                                    if (viewModel.isTaking == false) {
                                                      appViewModel
                                                          .changeTitle('포스트 등록');
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChangeNotifierProvider<
                                                                  RecordViewModel>(
                                                                create: (_) =>
                                                                    RecordViewModel(
                                                                      cameraViewModel
                                                                          .allFileList,
                                                                    ),
                                                                child: RecordView(),
                                                              ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              );
                                            })
                                          ],
                                        ),
                                        // 플래시 모드 변경
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            height: 30,
                                            color: Colors.black38,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton(
                                                  onPressed: () => {
                                                    cameraViewModel.controller
                                                        .setFlashMode(
                                                            FlashMode.auto)
                                                  },
                                                  icon: const Icon(
                                                    Icons.flash_auto,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () => {
                                                    cameraViewModel.controller
                                                        .setFlashMode(
                                                            FlashMode.off)
                                                  },
                                                  icon: const Icon(
                                                    Icons.flash_off,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () => {
                                                    cameraViewModel.controller
                                                        .setFlashMode(
                                                            FlashMode.torch)
                                                  },
                                                  icon: const Icon(
                                                    Icons.flashlight_on,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  });
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      );
    });
  }
}
