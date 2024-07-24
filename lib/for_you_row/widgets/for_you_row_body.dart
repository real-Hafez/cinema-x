import 'package:flutter/material.dart';

class for_you_row_body extends StatelessWidget {
  const for_you_row_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .05,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .06),
              child: Text(
                'For You',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .07,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * .06),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * .09),
                  splashColor: Colors.blueAccent.withOpacity(0.2),
                  highlightColor: Colors.blue.withOpacity(0.1),
                  onTap: () {},
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .07,
                      color: Colors.blue,
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
}
