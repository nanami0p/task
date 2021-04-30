import 'package:flutter/material.dart';

import '../widget/footerButton.dart';

class footerMenu {
    footerbtn _m_oWidgetbtn;
    footerMenu(){
        _m_oWidgetbtn = new footerbtn();
    }
    Widget myNavigationBar(PageController page_controller) {
        return SafeArea(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    _m_oWidgetbtn.mytask(page_controller),
                    _m_oWidgetbtn.othertask(page_controller),
                ],
            ),
        );
    }
    
    Widget floatingBtn(BuildContext context) {
        return  _m_oWidgetbtn.floatingBtn(context);
    }
}