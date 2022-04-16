import 'package:aigolive/landing/models/streamModel.dart';
import 'package:flutter/material.dart';

class StreamItem extends StatelessWidget {
  final List<StreamModel> streamList;
  final int index;
  final Function action;
  StreamItem({
    @required this.streamList,
    @required this.index,
    @required this.action,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                color: Colors.blue,
                width: double.maxFinite,
                height: 160,
                child: Image.network(
                  streamList[index].img,
                  fit: BoxFit.fitHeight,
                ),
              ),
              // Positioned(
              //   top: 4,
              //   left: 4,
              //   child: Row(
              //     children: [
              //       Container(
              //         width: 20.0,
              //         height: 20.0,
              //         padding: EdgeInsets.all(20),
              //         decoration: new BoxDecoration(
              //           border: Border.all(
              //             color: Colors.red,
              //             width: 1,
              //           ),
              //           color: Colors.white,
              //           shape: BoxShape.circle,
              //           image: new DecorationImage(
              //             fit: BoxFit.contain,
              //             image: NetworkImage(streamList[index].logo),
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: 5),
              //       Text(
              //         streamList[index].shopName,
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     ],
              //   ),
              // ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Live',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                left: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '${streamList[index].category}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        streamList[index].title +
                            " gkjg sdgkl sdlk gsdlkjg ;ag an",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        streamList[index].watching != null
                            ? '${streamList[index].watching} watching · ${streamList[index].date} · ${streamList[index].time}'
                            : 'Upcoming · ${streamList[index].date} · ${streamList[index].time}',
                        style: TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      action(context);
                    },
                    child: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
