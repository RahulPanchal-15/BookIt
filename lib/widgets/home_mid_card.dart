import 'package:flutter/material.dart';
import '../widgets/venue_containers.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class HomeMidCard extends StatelessWidget {
  final String? name;
  final String? location;
  final String? price;
  final ImageProvider? image;
  final void Function()? onClick;
  const HomeMidCard({
    Key? key,
    this.name,
    this.location,
    this.price,
    this.image,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Parameters: 1)Image, 2)Venue Name , 3) Price, 4) Location, 5)CallBack fn()
    return Card(
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      //For Rounding of image inside Container(sync card and image borderradius)
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Ink.image(
                // fit: BoxFit.fitWidth,

                fit: BoxFit.fitWidth,
                image: image!,
              ),
            ),
            Padding(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name!,
                        style: TextStyle(color: Colors.purple, fontSize: 20),
                      ),
                      //For Horizontal line
                      SizedBox(
                        height: 15.0,
                        width: 75.0,
                        child: Divider(
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        'Location: $location',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        'Price: $price',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: Text(
                        //if setFlag=1 , then Available
                        "Book",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: onClick,
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
    );
  }
}
// return
// Padding(
//       padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
//       child: Card(
//         elevation: 16,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         //For Rounding of image inside Container(sync card and image borderradius)
//         clipBehavior: Clip.antiAlias,
//         child: InkWell(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: Alignment.bottomLeft,
//                 children: [
//                   Ink.image(
//                     // fit: BoxFit.fitWidth,
//                     height: 100,
//                     fit: BoxFit.fitWidth,
//                     image: image!,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     // child: Text("Text checl!"),
//                   ),
//                 ],
//               ),
//               Padding(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(name!),
//                         //For Horizontal line
//                         SizedBox(
//                           height: 15.0,
//                           width: 75.0,
//                           child: Divider(
//                             color: Colors.purple,
//                           ),
//                         ),
//                         Text(
//                           'Location: $location',
//                           style: TextStyle(
//                             fontSize: 12.0,
//                           ),
//                         ),
//                         Text(
//                           'Price: $price',
//                           style: TextStyle(
//                             fontSize: 12.0,
//                           ),
//                         ),
//                       ],
//                     ),
//                     FlatButton(
//                       color: Colors.purple,
//                       onPressed: onClick,
//                       child: Text(
//                         "Book!",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 padding: EdgeInsets.all(8.0),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
