class ChannelList {
  final List<Channel> channelList;
  ChannelList({
    this.channelList,
  });
  factory ChannelList.fromJson(List<dynamic> json) {
    List<Channel> list = new List<Channel>();
    list = json.map((i) => Channel.fromJson(i)).toList();
    return ChannelList(
      channelList: list,
    );
  }
}

class Channel {
  final String status;
  final String logo;
  Channel({
    this.status,
    this.logo,
  });
  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      status: json['status'],
      logo: json['logo'],
    );
  }
}
