import 'package:flutter/material.dart';

class PostsWidgets extends StatelessWidget {
  const PostsWidgets();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sua saúde',
                style: TextStyle(
                  fontSize: 22 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2999999306 * ffem / fem,
                  color: Color(0xff1a1c22),
                ),
              ),
              TextButton(
                // masterbuttonmasterXEo (4902:28283)
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4 * fem),
                  ),
                  child: Text(
                    'See all',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.5 * ffem / fem,
                      color: Color(0xff52576a),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12 * fem),
              color: Color(0xfff1f8fd),
            ),
            child: Column(
              children: [
                Container(
                  width: 303 * fem,
                  height: 180 * fem,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8 * fem),
                      color: Colors.greenAccent),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 32 * fem,
                          height: 32 * fem,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          // ronaldrichardsRmR (I4511:32401;4504:25390)
                          'Ronald Richards',
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.6000000238 * ffem / fem,
                            color: Color(0xff1a1c22),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 60 * fem,
                      height: 20 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // calendarghM (I4511:32401;4504:25392)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 4 * fem, 0 * fem),
                            width: 16 * fem,
                            height: 16 * fem,
                            child: const Icon(
                              Icons.calendar_month_outlined,
                              size: 16,
                              color: Color(0xff878da0),
                            ),
                          ),
                          Text(
                            // zT9 (I4511:32401;4504:25393)
                            '27/04',
                            style: TextStyle(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4000000272 * ffem / fem,
                              color: Color(0xff878da0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saúde cardiovascular',
                        style: TextStyle(
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.5 * ffem / fem,
                          color: Color(0xff1a1c22),
                        ),
                      ),
                      Text(
                        // exploringvariousmentalhealthco (I4511:32401;4504:25396)
                        'Exploring various mental health conditions, coping strategies, and the importance of seeking professional help when needed.\n',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.4000000272 * ffem / fem,
                          color: Color(0xff52576a),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          // timeclockZYB (I4511:32401;4504:25398)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 4 * fem, 0 * fem),
                          width: 16 * fem,
                          height: 16 * fem,
                          child: Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: const Color(0xff52576a),
                          ),
                        ),
                        Text(
                          // minreadU9M (I4511:32401;4504:25399)
                          '20 min read',
                          style: TextStyle(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.4000000272 * ffem / fem,
                            color: Color(0xff878da0),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // speechbubblejLB (I4511:32401;4504:25401)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 4 * fem, 0 * fem),
                            width: 16 * fem,
                            height: 16 * fem,
                            child: Icon(
                              Icons.message_outlined,
                              size: 16,
                              color: Color(0xff2d72b3),
                            ),
                          ),
                          Text(
                            // comments35y (I4511:32401;4504:25402)
                            '243 comments',
                            style: TextStyle(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.7142857143 * ffem / fem,
                              color: Color(0xff2d72b3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
