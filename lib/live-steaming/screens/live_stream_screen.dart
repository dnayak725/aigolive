import 'dart:async';
import 'dart:convert';

import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/live-steaming/components/alertBoxComponent.dart';
import 'package:aigolive/live-steaming/models/LiveProductModel.dart';
import 'package:aigolive/live-steaming/providers/userMessageProvider.dart';
import 'package:aigolive/live-steaming/providers/video_player_provider.dart';
import 'package:aigolive/live-steaming/widgets/placeOrderWidget.dart';
import 'package:aigolive/live-steaming/widgets/productDetailsWidgets.dart';
import 'package:aigolive/live-steaming/widgets/productListWidgets.dart';
import 'package:aigolive/live-steaming/widgets/sellerDetailsWidget.dart';
import 'package:aigolive/live-steaming/widgets/shareIdeaWidget.dart';
import 'package:aigolive/live-steaming/widgets/userMessagesWidgets.dart';
import 'package:aigolive/stores/providers/followedStoresProvider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aigolive/live-steaming/providers/SessionDetailsProductsProvider.dart';

// import 'package:video_player/video_player.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LiveStreamScreen extends StatefulWidget {
  final StreamModel streamDetails;

  LiveStreamScreen(this.streamDetails);
  @override
  _LiveStreamScreenState createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  TextEditingController commentText = TextEditingController();
  Timer _timer;
  // _LiveStreamScreenState() {
  //   _timer = new Timer.periodic(const Duration(milliseconds: 1000), (timer) {
  //     print('Timer: testing' + timer.toString());
  //     getActiveViewers();
  //   });
  // }

  syncData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user_id')) {
      var userId = sharedPreferences.getString("user_id");
      await Provider.of<FollowedStoreProvider>(context, listen: false)
          .fetchData(userId);
    }
    await Provider.of<UserMessageProvider>(context, listen: false)
        .fetchData(widget.streamDetails.id);
    await Provider.of<SessionDetailsProductsProvider>(context, listen: false)
        .fetchData(widget.streamDetails.id);
  }

  getActiveViewers() async {
    print('Timer: object ');
    int value;
    final response = await http.get(
        'https://live.bluecube.com.sg/api/v1/applications/live/streams/AGL-Stream?accessToken=TV445VY4VC64VCTY4TC45RBIM7NTUYTME545YR');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Timer: object 1');
      // print('Timer: object ' + data['data']['active_subscribers'].toString());
      Provider.of<VideoPlayerProvider>(context, listen: false)
          .changeViewersValue(data['data']['active_subscribers']);
    }

    return value;
  }

  // VideoPlayerController controller;
  Future<void> futureController;
  // final String dataSource =
  //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  // final String dataSource = 'rtmp://192.168.0.151:1935/live/stream2';
  final TextEditingController _shareIdeaInput = new TextEditingController();
  int _productsViewMode = 1;
  bool _isRotatable = false;
  int _rotateMode = 0;
  final TextEditingController _emailController =
      new TextEditingController(text: 'nick@gmail.com');
  List<bool> isSelected;
  int _quantity = 1;
  int _initialPage;
  int _counter = 3;
  int _selectedProduct = 0;
  final CarouselController _carouselController = CarouselController();
  final ScrollController scrollController = new ScrollController();

  //code vlc player
  // String initUrl = "rtmp://live.bluecube.com.sg:1935/live/AGL105";
  //String initUrl = "https://quocent.com/assets/video/website_banner_video.mp4";
  // String changeUrl = "rtmp://192.168.0.160:1935/live/QStream";
  VlcPlayerController _vlcPlayerController;
  bool isPlaying = true;
  // Uint8List image;
  double currentPlayerTime = 0;
  double volumeValue = 100;
  String position = "";
  String duration = "";
  int numberOfCaptions = 0;
  int numberOfAudioTracks = 0;
  bool isBuffering = true;
  bool isStopped = false;
  bool isError = false;
  // bool getCastDeviceBtnEnabled = false;
  // double sliderValue = 0.0;
  int i = 0;
  @override
  void initState() {
    syncData();

    // controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    // controller =
    //     VideoPlayerController.network('rtsp://192.168.0.151:1935/live/stream1');
    // futureController = controller.initialize();
    // controller.setLooping(true);
    // controller.setVolume(25.0);

    // controller.play();

    isSelected = [true, false];

    //code for vlc player
    _vlcPlayerController = new VlcPlayerController(onInit: () {
      _vlcPlayerController.play();
    });
    _vlcPlayerController.addListener(() {
      if (!this.mounted) return;
      if (_vlcPlayerController.initialized) {
        // var oPosition = _vlcPlayerController.position;
        // var oDuration = _vlcPlayerController.duration;
        // if (oDuration.inHours == 0) {
        //   var strPosition = oPosition.toString().split('.')[0];
        //   var strDuration = oDuration.toString().split('.')[0];
        //   position =
        //       "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
        //   duration =
        //       "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
        // } else {
        //   position = oPosition.toString().split('.')[0];
        //   duration = oDuration.toString().split('.')[0];
        // }
        // sliderValue = _vlcPlayerController.position.inSeconds.toDouble();
        numberOfCaptions = _vlcPlayerController.spuTracksCount;
        numberOfAudioTracks = _vlcPlayerController.audioTracksCount;
        i++;
        switch (_vlcPlayerController.playingState) {
          case PlayingState.PAUSED:
            setState(() {
              isBuffering = false;
            });
            break;

          case PlayingState.STOPPED:
            setState(() {
              isPlaying = false;
              isBuffering = false;
              isStopped = true;
              // Navigator.of(context).pop();
            });
            break;
          case PlayingState.BUFFERING:
            setState(() {
              isBuffering = true;
            });
            break;
          case PlayingState.PLAYING:
            setState(() {
              isBuffering = false;
            });
            break;
          case PlayingState.ERROR:
            setState(() {
              isError = true;
            });
            print("VLC encountered error");
            break;
          default:
            setState(() {});
            break;
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    //controller.dispose();
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF232323),
      // backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          Center(
            // child: FutureBuilder(
            //   future: futureController,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       // return AspectRatio(
            //       //     aspectRatio: 3 / 2, child: VideoPlayer(controller),);//
            //       return Consumer<VideoPlayerProvider>(
            //         builder: (context, data, child) {
            //           return AspectRatio(
            //             aspectRatio: controller.value.aspectRatio,
            //             child: VideoPlayer(controller),
            //           );
            //         },
            //       );
            //     } else {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //   },
            // ),
            child: new VlcPlayer(
              aspectRatio: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height,
              url: widget.streamDetails.videoLink,
              isLocalMedia: false,
              controller: _vlcPlayerController,
              // Play with vlc options
              options: [
                '--quiet',
                //'-vvv',
                '--no-drop-late-frames',
                '--no-skip-frames',
                '--rtsp-tcp',
              ],
              hwAcc: HwAcc.DISABLED,
              // or {HwAcc.AUTO, HwAcc.DECODING, HwAcc.FULL}
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // color: Colors.red,
              child: (MediaQuery.of(context).orientation ==
                      Orientation.portrait)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // _portraitModeTopSection(),
                        SellerDetailsWidgets(
                          _rotateTheScreen,
                          widget.streamDetails,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(bottom: 30),
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black54,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: IconButton(
                                  onPressed: () {
                                    Provider.of<UserMessageProvider>(context,
                                            listen: false)
                                        .ChangeCommentSize(true);
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              UserMessageWidgets(),
                              Consumer<SessionDetailsProductsProvider>(
                                builder: (context,
                                        sessionDetailsProductsProvider,
                                        child) =>
                                    ProductListWidgets(
                                  liveProductList:
                                      sessionDetailsProductsProvider
                                          .sessionProducts,
                                  openProductView: _openProductDetails,
                                ),
                              ),
                              // _productsViewMode == 1
                              //     ? ProductListWidgets(
                              //         liveProductList: _liveProductList,
                              //         openProductView: _openProductDetails,
                              //       )
                              //     : (_productsViewMode == 2
                              //         ? _getProductViewWidget()
                              //         : Container()),
                              ShareIdeaWidget(
                                shareIdeaInputController: _shareIdeaInput,
                                sessionId: widget.streamDetails.id,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [
                                Colors.black38,
                                Colors.transparent,
                                Colors.black38,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SellerDetailsWidgets(
                                        _rotateTheScreen, widget.streamDetails),
                                    Container(
                                      // width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(
                                          bottom: 30, left: 15, right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: IconButton(
                                              onPressed: () {
                                                Provider.of<UserMessageProvider>(
                                                        context,
                                                        listen: false)
                                                    .ChangeCommentSize(true);
                                              },
                                              icon: Icon(
                                                Icons.keyboard_arrow_up,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          UserMessageWidgets(),
                                          ShareIdeaWidget(
                                            shareIdeaInputController:
                                                _shareIdeaInput,
                                            sessionId: widget.streamDetails.id,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Consumer<SessionDetailsProductsProvider>(
                                  builder: (context,
                                          sessionDetailsProductsProvider,
                                          child) =>
                                      ProductListWidgets(
                                    liveProductList:
                                        sessionDetailsProductsProvider
                                            .sessionProducts,
                                    openProductView: _openProductDetails,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        // _productsViewMode == 2
                        //     ? _getProductViewWidget()
                        //     : Container(),
                        // _productsViewMode == 3
                        //     ? PlaceOrderWidget(
                        //         changeToProductViewMode: _productViewMode,
                        //         emailController: _emailController,
                        //         isSelected: isSelected,
                        //         changePayNowButtonStatus:
                        //             _changePayNowButtonStatus,
                        //       )
                        //     : Container(),
                      ],
                    ),
            ),
          ),
          _productsViewMode == 3
              ? PlaceOrderWidget(
                  changeToProductViewMode: _productViewMode,
                  emailController: _emailController,
                  isSelected: isSelected,
                  changePayNowButtonStatus: _changePayNowButtonStatus,
                )
              : Container(),
          KeyboardVisibilityBuilder(builder: (context, visible) {
            return visible &&
                    MediaQuery.of(context).orientation == Orientation.landscape
                ? Container(
                    // width: EdgeInsets.in,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(top: 40, left: 15, right: 15),
                    color: Colors.white,
                    child: TextFormField(
                      controller: _shareIdeaInput,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 6, top: 0, bottom: 0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        hintStyle: TextStyle(color: Colors.black38),
                        hintText: "Share you ideas",
                      ),
                    ),
                  )
                : Container();
          }),
          //code for live streaming
          isBuffering
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  // color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: MyColors().lightGrey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(MyColors().iconColor),
                    ),
                  ),
                )
              : Container(),
          isError
              ? AlertBoxComponent(
                  'Hold On!', 'Live session has not started yet!!')
              : Container(),
          isStopped
              ? !isError
                  ? AlertBoxComponent('Session Closed!!', 'Click "ok" to back.')
                  : Container()
              : Container(),
          //end code for live streaming
          Positioned(
            bottom: 0,
            left: 20,
            child: Consumer<UserMessageProvider>(
              builder: (context, uMsg, child) => Visibility(
                visible:
                    Provider.of<UserMessageProvider>(context, listen: false)
                        .showFullPage,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height - 100,
                  width: MediaQuery.of(context).size.width - 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: CloseButton(
                            onPressed: () {
                              Provider.of<UserMessageProvider>(context,
                                      listen: false)
                                  .ChangeCommentSize(false);
                            },
                          ),
                        ),
                        Text(
                          "Comments",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 40.0,
                          child: TextField(
                            controller: commentText,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              suffixIcon: Container(
                                color: MyColors().blueDark,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.keyboard_return,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (commentText.text.length > 0) {
                                      Provider.of<UserMessageProvider>(context,
                                              listen: false)
                                          .addNewMessage(
                                              widget.streamDetails.id,
                                              commentText.text);
                                      commentText.text = "";
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            itemCount: uMsg.userMessage.length,
                            reverse: true,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: uMsg.userMessage[index].fullName +
                                            ": ",
                                        children: [
                                          TextSpan(
                                            text:
                                                uMsg.userMessage[index].message,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        uMsg.userMessage[index].time,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _getProductViewWidget() {
  //   if (MediaQuery.of(context).orientation == Orientation.portrait)
  //     return KeyboardVisibilityBuilder(builder: (context, visible) {
  //       return visible
  //           ? Container()
  //           : Container(
  //               width: MediaQuery.of(context).size.width,
  //               // padding: EdgeInsets.symmetric(horizontal: 15),
  //               child: ProductDetailsWidgets(
  //                 _selectedProduct,
  //                 _productListMode,
  //                 _productPurchaseMode,
  //                 _liveProductList,
  //                 _carouselController,
  //               ),
  //             );
  //     });
  //   else
  //     return Container(
  //       color: Colors.black38,
  //       width: MediaQuery.of(context).size.width,
  //       // padding: EdgeInsets.symmetric(horizontal: 15),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           GestureDetector(
  //             onTap: _productListMode,
  //             child: Container(
  //               // color: Colors.black38,
  //               width: MediaQuery.of(context).size.width * 0.5,
  //             ),
  //           ),
  //           Container(
  //             // color: Colors.black38,
  //             width: MediaQuery.of(context).size.width * 0.5,
  //             child: ProductDetailsWidgets(_selectedProduct, _productListMode,
  //                 _productPurchaseMode, _liveProductList, _carouselController),
  //           ),
  //         ],
  //       ),
  //     );
  // }

  _rotateTheScreen() {
    if (_rotateMode == 0) {
      _rotateMode = 1;
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      _rotateMode = 0;
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  _productListMode() {
    setState(() {
      _productsViewMode = 1;
    });
  }

  _productViewMode() {
    setState(() {
      _productsViewMode = 2;
    });
    // print(_productsViewMode);
  }

  _productPurchaseMode() {
    setState(() {
      _productsViewMode = 3;
    });
  }

  _openProductDetails(int index) {
    setState(() {
      _selectedProduct = index;
      _productsViewMode = 2;
    });
  }

  _changePayNowButtonStatus(index) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = i == index;
      }
    });
  }
}
