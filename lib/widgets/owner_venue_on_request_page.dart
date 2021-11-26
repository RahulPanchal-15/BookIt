import 'package:flutter/material.dart';
import '../widgets/venue_containers.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class OwnerVenueCard extends StatelessWidget {
  final ImageProvider? image;

  const OwnerVenueCard({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Parameters: 1)Image, 2)Venue Name , 3) Price, 4) Location, 5)CallBack fn()
    return Card(
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      //For Rounding of image inside Container(sync card and image borderradius)
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Image(
            fit: BoxFit.fitWidth,
            height: 150,
            image: image!,
          ),
        ],
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
