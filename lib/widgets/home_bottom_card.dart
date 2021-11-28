import 'package:assignment_practice/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/venue_containers.dart';

class HomeBottomCard extends StatelessWidget {
  final String? name;
  final String? location;
  final String? price;
  final ImageProvider? image;

  final String? filterName;
  final void Function()? onClick;
  const HomeBottomCard({
    Key? key,
    this.name,
    this.location,
    this.price,
    this.image,
    this.filterName,
    this.onClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
      child: Card(
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //For Rounding of image inside Container(sync card and image borderradius)
        clipBehavior: Clip.antiAlias,
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              fit: BoxFit.cover,
              width: 80,
              height: 80,
              image: image!,
            ),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name!,
                            style: TextStyle(color: Colors.white),
                          ),
                          //For Horizontal line
                          SizedBox(
                            height: 10.0,
                            width: 100.0,
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Location: $location',
                            style: kHomeBottomCardTextStyle,
                          ),
                          Text(
                            "Price: $price",
                            style: kHomeBottomCardTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.black)),
                              ),
                            ),
                            child: Text(
                              filterName!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                          width: 75.0,
                        ),
                        SizedBox(
                          height: 20,
                          child: ElevatedButton(
                            onPressed: onClick,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
