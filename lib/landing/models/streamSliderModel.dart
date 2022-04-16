class SliderList {
  final List<SlideImageList> sliderList;
  SliderList({
    this.sliderList,
  });
  factory SliderList.fromJson(List<dynamic> json) {
    List<SlideImageList> slideImageList = new List<SlideImageList>();
    slideImageList = json.map((i) => SlideImageList.fromJson(i)).toList();
    return SliderList(
      sliderList: slideImageList,
    );
  }
}

class SlideImageList {
  final List<SlideImage> streams;
  final String status;
  SlideImageList({this.streams, this.status});
  factory SlideImageList.fromJson(Map<String, dynamic> json) {
    var list = json['streams'] as List;
    List<SlideImage> imageList =
        list.map((i) => SlideImage.fromJson(i)).toList();
    return SlideImageList(
      streams: imageList,
      status: json['status'],
    );
  }
}

class SlideImage {
  final String img;
  SlideImage({this.img});
  factory SlideImage.fromJson(Map<String, dynamic> json) {
    return SlideImage(
      img: json['img'],
    );
  }
}
