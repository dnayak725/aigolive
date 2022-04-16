import 'package:flutter/material.dart';

class LoadingPreview extends StatelessWidget{
  final Axis widgetDirection;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const LoadingPreview({Key key, this.widgetDirection, this.crossAxisCount, this.childAspectRatio, this.crossAxisSpacing, this.mainAxisSpacing}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
                  physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              scrollDirection: widgetDirection,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
              ),
              itemBuilder: (ctx, index) {
                  return  Container(
                            width:
                                (MediaQuery.of(context).size.width - 30) * .42,
                            height:
                                (MediaQuery.of(context).size.width - 30) * .62,
                            margin: EdgeInsets.symmetric(
                              horizontal: 6,
                            ),
                            decoration: new BoxDecoration(
                              // border: Border.all(width: 1),
                              color: Colors.blue,
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                image:
                                    AssetImage("assets/images/loading-preview.gif"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
              }
                  
                );
  }
  
}