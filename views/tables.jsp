<%--
  Created by IntelliJ IDEA.
  User: smhrd
  Date: 2022-09-27
  Time: 오후 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="src.model.DamDataDTO" %>
<%@ page import="src.model.DamDataDAO" %>
<%@ page import="src.model.DamStatusDAO" %>
<%@ page import="src.model.DamStatusDTO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="../assets/img/water-icon.png">
    <title>
        저수지역 예측수심
    </title>
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css"
          href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700"/>
    <!-- Nucleo Icons -->
    <link href="../assets/css/nucleo-icons.css" rel="stylesheet"/>
    <link href="../assets/css/nucleo-svg.css" rel="stylesheet"/>
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <!-- CSS Files -->
    <link id="pagestyle" href="../assets/css/material-dashboard.css?v=3.0.2" rel="stylesheet"/>
</head>

<body class="g-sidenav-show  bg-gray-200">
<style>
    @charset "utf-8";
    /* 댐/보 */
    #container.dam .inner {
        padding-bottom: 0px;
    }

    .damMap {
        width: 100%;
    }

    .damMap img {
        width: 100%;
    }

    .damsWrap .topSearch {
    }

    .damsWrap .topSearch select,
    .damsWrap .topSearch input {
        margin: 0;
        padding: 7px 0;
        color: #717171;
    }

    .damsWrap .topSearch .selBox01 {
        width: 100%;
        margin-bottom: 5px;
    }

    .damsWrap .topSearch .selBox01.selEa1 select {
        width: 25%;
    }

    .damsWrap .topSearch .selBox01.selEa2 select {
        width: 30%;
    }

    .damsWrap .topSearch .selBox01.selEa3 select {
        width: 25%;
    }

    .damsWrap .topSearch .selBox02.selEa3,
    .damsWrap .topSearch .selBox02.selEa1 {
        width: 100%;
    }

    .damsWrap .topSearch .selBox02.selEa1 select {
        width: 25%;
    }

    .damsWrap .topSearch .selBox02.selEa3 select {
        width: 25%;
    }

    .damsWrap .topSearch .inBox01 span {
        text-align: left;
    }

    .damsWrap .topSearch select {
        height: 34px;
        padding-top: 2px !important
    }

    .damsWrap .topSearch .label,
    .damsWrap .topSearch label {
        width: 60px;
        display: inline-block;
    }

    .damsWrap .worksTable {
        margin-top: 5px;
    }

    .damsWrap .worksTable.fz10 {
        font-size: 10px;
    }

    .damsWrap .worksTable th {
        vertical-align: middle;
    }

    .damsWrap .worksTable.thBold th {
        font-weight: bold;
    }

    .damsWrap .worksTable.thBold th:first-child {
        border-left: 1px solid #ececec !important;
    }

    .damsWrap .worksTable tr th {
        padding: 7px 2px 7px 2px;
        font-size: 14px;
    }

    .damsWrap .worksTable tr td {
        padding: 7px 2px 7px 2px;
        font-size: 14px;
    }

    .damsWrap .subTx {
        margin-bottom: 10px;
    }

    .damsWrap .btnDown {
        text-align: right;
        line-height: 22px;
        vertical-align: top;
    }

    .damsWrap .txDt dt {
        font-weight: bold;
    }

    .damsWrap .tabBtn01 {
        margin: 0;
        margin-bottom: 20px;
    }

    .damsWrap .realtime_topSearch.grap {
        margin-top: 30px;
    }

    .damsWrap .realtime_topSearch.grap .selBox01 {
        margin-bottom: 0px;
    }

    .damsWrap .realtime_topSearch.grap .inBox02 img {
        width: 73px;
    }

    .damsWrap .graphBox {
        width: 500px;
        margin: 0 auto;
    }

    .damsWrap .graphBox_re {
        width: 100%;
        padding-top: 25px;
        margin: 0 auto;
    }

    .damsWrap .graphBox.sihwa {
        width: 100%;
    }

    .damsWrap .graphBox img {
        width: 100%;
    }


    .ui-jqgrid .ui-jqgrid-htable th div {
        overflow: hidden;
        position: relative;
        display: inline-block;
        height: auto;
        padding: 4px 2px;
        vertical-align: middle;
        white-space: normal !important;
    }

    .main_table {
        width: 100%;
        border: solid;
        border-width: 0px 0px 0px 0px;
        text-align: center;
        font-size: 9pt;
    }

    .damsWrap .worksTable tr td.layout_td {
        padding: 0 !important;
        vertical-align: top
    }

    .damsWrap .worksTable tr td.layout_td .main_table.bg_header td {
        color: #323232;
        font-weight: bold;
        background: #f7f8fb
    }

    .damsWrap .worksTable tr td.layout_td .main_table tbody tr:first-child td {
        border-top-width: 0 !important
    }

    .worksTable tbody tr td.line_no_top td {
        padding: 0;
        line-height: 0;
        border: none !important
    }

    .tabBtn {
        margin-bottom: 10px
    }

    .buildList .typeTitle {
        margin-bottom: 8px !important
    }

    .buildList a {
        font-size: 12px !important
    }

    .buildList li {
        margin-top: 2px
    }

    .buildList li a:before {
        width: 13px;
        height: 14px;
        background-size: 27px
    }

    .buildList li.on a:before {
        background-position: -14px 0
    }

    .realtime_dam_info {
        position: relative;
        min-height: 530px
    }

    .realtime_dam_info h2 {
        margin-top: 10px !important

    }

    .realtime_dam_info .btnDown {
        position: absolute;
        top: 10px;
        right: 0
    }

    .dam_thum_info {
        overflow: hidden;
        padding-left: 365px
    }

    .dam_thum_info .thum_area {
        position: absolute;
        left: 0;
        width: 350px
    }

    .dam_thum_info .thum_area img {
        display: block;
        width: 100%;
        height: 242px;
        margin-bottom: 6px
    }

    .dam_thum_info table {
        margin-top: 0 !important
    }

    /* .dam_thum_info table th,.dam_thum_info table td{font-size:11px !important} */
    .dam_thum_info table th:first-child {
        border-left-width: 1px !important
    }

    .dam_thum_info table th, .dam_thum_info table td {
        padding: 7px 2px !important;
    }

    .dam_thum_info table td {
        border-left: 1px solid #ececec
    }

    .dam_thum_info table tr:first-child th, .dam_thum_info table th[rowspan], .dam_thum_info table.tb_oneRow th {
        border-left-width: 0 !important
    }

    .dam_thum_info table sup, .sup_11, .sup_11 sup {
        font-size: 11px
    }

    /* 댐보 탭 */
    .damsWrap h2 {
        font-weight: bold;
        font-size: 16px;
        margin: 15px 0 15px 0;
    }

    .worksWrap .tabBtn03 a,
    .damsWrap .tabBtn03 a {
        float: left;
        padding: 5px 0;
        background: #ededed;
        min-width: 100px;
        margin-right: 2px;
        text-align: center;
        font-size: 14px;
    }

    .worksWrap #tabBtn-name a,
    .damsWrap #tabBtn-name a {
        line-height: 25px ! important;
        min-width: 70px;
    }

    .worksWrap .tabBtn03 a:hover,
    .worksWrap .tabBtn03 a:focus,
    .worksWrap .tabBtn03 a:active,
    .worksWrap .tabBtn03 a.on,
    .damsWrap .tabBtn03 a:hover,
    .damsWrap .tabBtn03 a:focus,
    .damsWrap .tabBtn03 a:active,
    .damsWrap .tabBtn03 a.on {
        background: #fc9e32;
        font-weight: bold;
        letter-spacing: -1px;
        color: #fff;
    }


    /* 댐/보 수질자료 */
    .damsWrap .graph01Box {
        margin-bottom: 30px;
    }

    .damsWrap .graph01Box .radioBox {
        line-height: 24px;
        padding: 10px 0;
        text-align: right;
    }

    .damsWrap .graph01Box .radioBox input {
        margin-left: 10px;
        border-width: 0
    }

    .damsWrap .graph01Box .inBox p {
        font-size: 14px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 5px;
    }

    .damsWrap .graph01Box .inBox .graph01 {
        margin-right: 10px;
    }

    .damsWrap .graph01Box .inBox .graph01,
    .damsWrap .graph01Box .inBox .graph02 {
        float: left;
        width: 49%;
    }

    .damsWrap .graph01Box .inBox .graph01 img,
    .damsWrap .graph01Box .inBox .graph02 img {
        width: 100%;
    }

    /* 수도/댐용수요금안내 */
    .char06.charWrap.centerBox .txAlign {
        text-align: center;
    }

    /* 댐/보 실시간영상 */
    .damsWrap .notiBox div.txBox {
        padding: 12px 8.05% 12px 0;
    }

    .damsWrap .videoBox .imgBox {
        float: left;
        width: 286px;
    }

    .damsWrap .videoBox .txBox {
        margin-left: 320px;
    }

    .damsWrap .videoBox .txBox p {
        padding-top: 20px;
    }

    .damsWrap .videoBox .txBox .system {
        margin-top: 60px;
    }

    .damsWrap .videoBox .txBox .system strong {
        font-weight: bold;
        font-size: 16px;
        margin-bottom: 10px;
        display: inline-block;
    }

    .damsWrap .videoBox .txBox .system ul {
        color: #047ab3;
        font-weight: bold;
    }

    .damsWrap .videoBox .txBox .targetBtnBox {
        margin-top: 40px;
    }

    /* 수도 */
    .damsWrap .selectBox select {
        padding: 5px 0;
    }

    .damsWrap .topsBox .selectBox {
        float: left;
        width: 60%;
    }

    .damsWrap .topsBox .selectBox input[type=image] {
        width: 70px;
    }

    .damsWrap .topsBox .tabBtn03 {
        float: left;
        width: 40%;
    }

    .damsWrap.winfo {
        padding-top: 20px;
    }

    .damsWrap.winfo .tabBtn03 a {
        float: none;
        padding: 7px 15px;
    }

    .damsWrap.winfo .tabBtn03 strong {
        font-weight: bold;
    }

    .damsWrap.winfo .topSearch .inBox01 span.selBox01.selEa2 {
        padding-left: 64px;
    }

    .damsWrap.winfo .topSearch .inBox01 span strong {
        font-weight: bold;
    }

    .damsWrap.winfo .worksTable.scroll th {
        border-left: 1px solid #ececec;
    }

    /*.damsWrap.winfo .worksTable.scroll th:first-child{border-left:none;}*/
    .damsWrap.winfo .worksTable {
        margin-bottom: 50px;
    }

    .damsWrap.winfo .worksTable tbody tr td:first-child {
        text-align: center;
        padding: 7px 15px;
    }

    .damsWrap.winfo .worksTable caption {
        font-size: 0;
    }

    .damsWrap .custMap .mapBox01,
    .damsWrap .custMap .txBox {
        width: 50%;
        float: left;
    }

    .damsWrap .custMap .txBox {
    }

    .damsWrap .custMap .txBox h2 {
        margin-top: 0;
    }

    .damsWrap .custMap .txBox h3 {
        font-weight: bold;
        font-size: 14px;
        color: #017eba;
        margin: 20px 0 10px 0;
    }

    /* 스크롤박스 */
    .scrollBox {
        width: 100%;
        height: 500px;
        overflow-x: scroll;
        overflow-y: scroll;
        margin-bottom: 20px;
    }

    .scrollBox .worksTable.scroll {
        width: 1400px;
    }

    .scrollBox .worksTable.scroll.size01 {
        width: 1200px;
    }

    .scrollBox .worksTable.scroll th {
        border-left: 1px solid #ececec;
        vertical-align: middle;
    }

    .scrollBox .worksTable.scroll th:first-child {
        border-left-width: 0;
    }

    .scrollBox .worksTable.scroll .bL0 {
        border-left: 0 !important;
    }

    .scrollBox .worksTable.scroll .bR0 {
        border-right: 0 !important;
    }

    .scrollBox .worksTable.scroll01 {
        width: 1600px;
    }

    .scrollBox .worksTable.scroll td {
        text-align: right;
    }

    .scrollBox .worksTable.scroll tfoot th,
    .scrollBox .worksTable.scroll tfoot td,
    .scrollBox .worksTable.scroll .bgPoint {
        background: #fafafa;
    }

    /* 건설중인 댐현황
    .buildList {overflow:hidden;width:100%;margin-bottom:20px;padding-bottom:20px;border-bottom:1px solid #e2e2e2;}
    .buildList strong {font-weight:bold;}
    .buildList > p {float:left;margin-right:30px;}
    .buildList ul {overflow:hidden;}
    .buildList .right {width:395px;float:right;}
    .buildList {clear:both;content:'';display:block;}

    .buildList .img img {width:275px;height:357px;}
    .buildList .img.build03 img {width:375px;height:477px;}
    .buildList .typeTitle {font-size:16px;font-weight:bold;color:#323232;margin-bottom:15px;}
    .buildList .bltType1.type2 {width:19%;float:left;}
    .buildList .bltType1.type3 {width:15%;float:left;}
    .buildList .bltType2.type2,.buildList .bltType3.type3,.buildList .bltType4.type3{width:15%;float:left;}

    .buildList.Info {margin-top:40px;border-bottom:none;}
    .buildList.Info p {margin-right:0;}
    .buildList.Info h2 {font-size:22px;font-weight:bold;color:#323232;margin-bottom:20px;}
    .buildList.Info h3 {font-size:16px;font-weight:bold;color:#323232;}
    .buildList.Info .img img {height:233px;}
    .buildList.Info .img {font-size:12px;color:#717171;text-align:right;margin-bottom:10px;}
    .buildList .img.type2 {}
    .buildList .map-waterShed {width:300px;height:425px;background:url('/images/egovframework/renewal/contents/realtimap_map_dam.jpg') no-repeat;}
    .buildList .map-area{width:300px;height:425px;background:url('/images/egovframework/renewal/contents/operate_map_dam.jpg') no-repeat;}
    #tab-contentArea span{position:absolute;display:inline-block;width:80px;height:50px;background-image:url('/images/egovframework/renewal/contents/oper_map_dam.png');text-indent:-999px;}
    #tab-contentShed span{position:absolute;display:inline-block;width:80px;height:50px;background-image:url('/images/egovframework/renewal/contents/area_map_dam.png');text-indent:-999px;}
    .damBox-map{position:relative;float:left;overflow:hidden;}
    .damBox-map > div{overflow:hidden;float:left;width:300px;height:425px;}
    .tabBtn-group{position:absolute;right:8px;bottom:10px;}
    .damBox-name{display:inline-block;float:left;width:410px;margin-left:15px;}
    .damBox-name .typeTitle{font-size:12px;background:#f7f8fb;padding:5px;margin:0 2px;}
     .buildList .damBox-name ul{width:25%! important;}
    .damBox-name ul li{font-size:12px;margin:0 3px;}


    .buildList .img.type2  .img_1012110{top:20px;right:90px;background-position:0 0;}
    .buildList .img.type2  .img_1003110{top:113px;right:117px;background-position:-85px 0;}
    .buildList .img.type2  .img_1006110{top:40px;right:85px;background-position:-160px 0;}
    .buildList .img.type2  .img_2001110{top:130px;right:35px;background-position:-240px 0;}
    .buildList .img.type2  .img_2002110{top:137px;right:30px;background-position:-320px 0;}
    .buildList .img.type2  .img_2015110{top:240px;right:105px;background-position:0 -60px;}
    .buildList .img.type2  .img_2018110{top:260px;right:110px;background-position:-75px -60px;}
    .buildList .img.type2  .img_2021110{top:245px;right:60px;background-position:-163px -60px;}
    .buildList .img.type2  .img_2008101{top:160px;right:55px;background-position:-240px -60px;}
    .buildList .img.type2  .img_2010101{top:200px;right:90px;background-position:-320px -60px;}
    .buildList .img.type2  .img_2004101{top:145px;right:40px;background-position:-0px -120px;}
    .buildList .img.type2  .img_2002111{top:185px;right:55px;background-position:-85px -120px;}
    .buildList .img.type2  .img_2012101{top:220px;right:40px;background-position:-170px -120px;}
    .buildList .img.type2  .img_3008110{top:145px;right:142px;background-position:-245px -120px;}
    .buildList .img.type2  .img_3001110{top:200px;right:148px;background-position:-320px -120px;}
    .buildList .img.type2  .img_4001110{top:215px;right:170px;background-position:0 -180px;}
    .buildList .img.type2  .img_4007110{top:283px;right:178px;background-position:-78px -180px;}
    .buildList .img.type2  .img_3303110{top:218px;left:25px;background-position:-160px -180px;}
    .buildList .img.type2  .img_3203110{top:165px;left:32px;background-position:-245px -180px;}
    .buildList .img.type2  .img_5101110{bottom:70px;left:25px;background-position:-325px -180px;}
    .buildList .img.type2  .img_2022510{bottom:118px;right:55px;background-position:0 -240px;}

    .kang-won a{color:#ae8a51;}
    .kang-won a:before{background:url('/images/egovframework/renewal/contents/mapcat_gw.png') no-repeat 0 0! important;}
    .gyeong-gi a{color:#dc6a35;}
    .gyeong-gi a:before{background:url('/images/egovframework/renewal/contents/mapcat_gg.png') no-repeat 0 0! important;}
    .chung-nam a{color:#4cac36;}
    .chung-nam a:before{background:url('/images/egovframework/renewal/contents//mapcat_cn.png') no-repeat 0 0! important;}
    .chung-buk a{color:#9b8847;}
    .chung-buk a:before{background:url('/images/egovframework/renewal/contents/mapcat_cb.png') no-repeat 0 0! important;}
    .gyeong-buk a {color:#c76955;}
    .gyeong-buk a:before{background:url('/images/egovframework/renewal/contents/mapcat_gb.png') no-repeat 0 0! important;}
    .gyeong-nam a {color:#42937b;}
    .gyeong-nam a:before{background:url('/images/egovframework/renewal/contents/mapcat_gn.png') no-repeat 0 0! important;}
    .jeon-nam a {color:#4255ca;}
    .jeon-nam a:before{background:url('/images/egovframework/renewal/contents/mapcat_jn.png') no-repeat 0 0! important;}
    .jeon-buk a {color:#c36c3c;}
    .jeon-buk a:before{background:url('/images/egovframework/renewal/contents/mapcat_jb.png') no-repeat 0 0! important;}
    */
    .yongsu_dam01 {
        top: 124px;
        left: 244px
    }

    .yongsu_dam02 {
        top: 89px;
        left: 232px
    }

    .yongsu_dam03 {
        top: 257px;
        left: 240px
    }

    .yongsu_dam04 {
        top: 209px;
        left: 255px
    }

    .yongsu_dam05 {
        top: 232px;
        left: 263px
    }

    .yongsu_dam06 {
        top: 281px;
        left: 233px
    }

    .yongsu_dam07 {
        top: 178px;
        left: 195px
    }

    .yongsu_dam08 {
        top: 191px;
        left: 202px
    }

    .yongsu_dam09 {
        top: 320px;
        left: 248px
    }

    .yongsu_dam10 {
        top: 302px;
        left: 243px
    }

    .yongsu_dam11 {
        top: 359px;
        left: 224px
    }

    .yongsu_dam12 {
        top: 337px;
        left: 148px
    }

    .yongsu_dam13 {
        top: 375px;
        left: 86px
    }

    .yongsu_dam14 {
        top: 327px;
        left: 35px
    }


    /* 용수댐 */
    .buildList .img.type2 .img_1001210 {
        top: 70px;
        right: 39px;
        background-position: 0 -310px;
    }

    .buildList .img.type2 .img_1302210 {
        top: 52px;
        right: 39px;
        background-position: -80px -310px;
    }

    .buildList .img.type2 .img_2012210 {
        top: 198px;
        right: 47px;
        background-position: -180px -310px;
    }

    .buildList .img.type2 .img_2101210 {
        top: 192px;
        right: 25px;
        background-position: -240px -310px;
    }

    .buildList .img.type2 .img_2403201 {
        top: 209px;
        right: 12px;
        background-position: -322px -310px;
    }

    .buildList .img.type2 .img_2021210 {
        top: 205px;
        right: 44px;
        background-position: 0 -370px;
    }

    .buildList .img.type2 .img_2201231 {
        top: 208px;
        right: 25px;
        background-position: -80px -370px;
    }

    .buildList .img.type2 .img_2201220 {
        top: 213px;
        right: 21px;
        background-position: -160px -370px;
    }

    .buildList .img.type2 .img_2201230 {
        top: 221px;
        right: 22px;
        background-position: -240px -370px;
    }

    .buildList .img.type2 .img_2301210 {
        top: 219px;
        right: 19px;
        background-position: -320px -370px;
    }

    .buildList .img.type2 .img_2503210 {
        top: 282px;
        right: 76px;
        background-position: 0 -430px;
    }

    .buildList .img.type2 .img_2503220 {
        top: 301px;
        right: 79px;
        background-position: -80px -430px;
    }

    .buildList .img.type2 .img_4105210 {
        bottom: 90px;
        left: 75px;
        background-position: -160px -430px;
    }

    .buildList .img.type2 .img_5002201 {
        bottom: 108px;
        left: -3px;
        background-position: -250px -430px;
    }

    /* 다기능보 */
    .buildList .img.type2 .img_1007603 {
        top: 70px;
        left: 98px;
        background-position: 0 -550px;
    }

    .buildList .img.type2 .img_1007602 {
        top: 78px;
        left: 89px;
        background-position: -80px -550px;
    }

    .buildList .img.type2 .img_1007601 {
        top: 107px;
        left: 87px;
        background-position: -160px -550px;
    }

    .buildList .img.type2 .img_2017601 {
        bottom: 132px;
        right: 57px;
        background-position: 0 -610px;
    }

    .buildList .img.type2 .img_2014602 {
        bottom: 133px;
        right: 85px;
        background-position: -80px -610px;
    }

    .buildList .img.type2 .img_2014601 {
        bottom: 148px;
        right: 79px;
        background-position: -160px -610px;
    }

    .buildList .img.type2 .img_2011602 {
        bottom: 161px;
        right: 80px;
        background-position: -240px -610px;
    }

    .buildList .img.type2 .img_2011601 {
        bottom: 169px;
        right: 77px;
        background-position: -320px -610px;
    }

    .buildList .img.type2 .img_2009602 {
        bottom: 186px;
        right: 87px;
        background-position: 0 -670px;
    }

    .buildList .img.type2 .img_2009601 {
        top: 180px;
        right: 88px;
        background-position: -80px -670px;
    }

    .buildList .img.type2 .img_2007601 {
        top: 153px;
        right: 96px;
        background-position: -160px -670px;
    }

    .buildList .img.type2 .img_3012602 {
        top: 169px;
        left: 43px;
        background-position: -240px -670px;
    }

    .buildList .img.type2 .img_3012601 {
        top: 160px;
        left: 47px;
        background-position: -320px -670px;
    }

    .buildList .img.type2 .img_3010601 {
        top: 157px;
        left: 54px;
        background-position: 0 -730px;
    }

    .buildList .img.type2 .img_5004602 {
        bottom: 85px;
        left: 7px;
        background-position: -80px -730px;
    }

    .buildList .img.type2 .img_5004601 {
        bottom: 85px;
        left: 23px;
        background-position: -160px -730px;
    }

    /* 홍수조절용댐 */
    .buildList .img.type2 .img_1009710 {
        top: 2px;
        left: 126px;
        background-position: 0 -490px;
    }

    .buildList .img.type2 .img_1022701 {
        top: 5px;
        left: 75px;
        background-position: -80px -490px;
    }

    .buildList .img.type2 .img_1021701 {
        top: 15px;
        left: 69px;
        background-position: -160px -490px;
    }

    /* 홍수조절지 */
    .buildList .img.type2 .img_5001701 {
        bottom: 136px;
        left: 28px;
        background-position: -240px -490px;
    }

    .buildList .img.type2 .img_5003701 {
        bottom: 97px;
        left: 26px;
        background-position: -320px -490px;
    }

    .buildList .img.type2 .img_1007701 {
        top: 78px;
        left: 83px;
        background-position: -240px -550px;
    }

    .buildList .img.type2 .img_4104610 {
        bottom: 89px;
        left: 64px;
        background-position: -320px -550px;
    }


    /* 탭박스 */
    .tabBoxGray {
        overflow: hidden;
        margin-bottom: 30px;
    }

    .tabBoxGray ul:after {
        clear: both;
        content: "";
        display: block;
    }

    .tabBoxGray ul li {
        float: left;
        background: #ebebeb;
        border-right: 2px solid #fff;
        box-sizing: border-box;
        padding: 10px 25px;
    }

    .tabBoxGray ul li a {
        display: inline-block;
        width: 100%;
        height: 100%;
        font-size: 14px;
        color: #000;
    }

    .tabBoxGray ul li.on {
        background: #047ab3;
    }

    .tabBoxGray ul li.on a {
        color: #fff;
    }


    /* 사업위치도 */

    .bltRound {
        margin-bottom: 20px;
    }

    .bltRound li {
        padding-left: 20px;
        font-size: 14px;
        background-repeat: no-repeat;
        background-position: 0 5px;
        line-height: 24px
    }

    .bltRound li.blue {
        background-image: url('/images/egovframework/realtime/web/images/busi/blt_color1.gif');
    }

    .bltRound li.Lblue {
        background-image: url('/images/egovframework/realtime/web/images/busi/blt_color2.gif');
    }

    .bltRound li.orange {
        background-image: url('/images/egovframework/realtime/web/images/busi/blt_color3.gif');
    }

    .img100 img {
        width: 100%;
    }

    .bltRound.type2 li {
        padding-left: 35px;
    }

    .bltRound.type2 li.blue {
        background-image: url('/images/egovframework/realtime/web/images/busi/blt_color11.gif');
    }

    .bltRound.type2 li.Lblue {
        background-image: url('/images/egovframework/realtime/web/images/busi/blt_color12.gif');
    }

    .bltRound.type2 li.orange {
        background-image: url('/images/egovframework/realtime/web/images/busi/blt_color13.gif');
    }

    table.newEng {
        width: 100%;
        border-top: 2px solid #12a3cc;
        margin-bottom: 5px;
    }

    table.newEng thead th {
        background: #f7f8fb;
        border-left: 1px solid #ececec;
        vertical-align: middle;
        padding: 5px 0;
    }

    table.newEng thead th:first-child {
        border-left: none;
    }

    table.newEng tbody th {
        border-bottom: 1px solid #ECECEC;
    }

    table.newEng td {
        text-align: center;
        border-left: 1px solid #ECECEC;
        border-bottom: 1px solid #ECECEC;
        padding: 8px 0;
    }

    table.newEng th span {
        display: inline-block;
        width: 35%;
    }

    table.newEng .topLine {
        border-top: 1px solid #ECECEC
    }

    table.rowTable {
        width: 100%;
        border-top: 2px solid #12A3CC;
    }

    table.rowTable thead th {
        background: #F7F8FB;
        padding: 8px 0;
        font-weight: bold;
        font-weight: bold;
        vertical-align: middle;
    }

    table.rowTable tbody th {
        border-bottom: 1px solid #ececec;
        border-left: 1px solid #ececec;
        padding: 8px 0;
        vertical-align: middle;
    }

    table.rowTable tbody th:first-child {
        border-left: none;
    }

    table.rowTable tbody th.lineLeft {
        border-left: 1px solid #ECECEC
    }

    table.rowTable tbody td {
        border-bottom: 1px solid #ECECEC;
        border-left: 1px solid #ECECEC;
        padding: 8px 0;
        text-align: center;
    }

    table.rowTable tbody td.none {
        border-left: none;
    }

    table.rowTable.supp tbody td {
        text-align: left;
        padding-left: 50px;
    }

    table.rowTable.arryLeft tbody td {
        text-align: left;
        padding: 8px 10px;
    }

    table.rowTable tr.inputW80 td input {
        width: 80%;
    }

    table.rowTable.center thead tr th {
        text-align: center !important
    }

    table.rowTable.center tbody tr td {
        text-align: center !important;
    }

    table.rowTable.center tbody tr td:first-child {
        border-left: none !important;
    }

    table.rowTable.left tbody tr td:first-child {
        border-left: none !important
    }

    table.rowTable.left tbody tr td {
        padding: 8px 10px;
        text-align: left;
    }

    table.rowTable.left tbody tr td.lineLeft {
        border-left: 1px solid #ECECEC !important;
    }

    table.rowTable tbody.firstTxtCnt tr td:first-child {
        text-align: center !important;
    }

    table.rowTable tbody tr td.left {
        padding: 8px 10px;
        text-align: left !important
    }

    table.rowTable tbody tr td.center {
        text-align: center !important;
    }

    table.rowTable tbody tr td a {
        vertical-align: top;
        margin-left: 5px;
    }

    table.colTable {
        width: 100%;
        border-top: 2px solid #12a3cc;
        border-bottom: 1px solid #d1d1d1;
    }

    table.colTable tbody th {
        text-align: center;
        background: #f7f9fa;
        border-top: 1px solid #e2e2e2;
        padding: 8px 0;
        font-weight: bold;
        color: #323232;
        vertical-align: middle;
    }

    table.colTable tbody th.brdNone {
        border-top: none;
    }

    table.colTable tbody td {
        padding: 8px 12px;
        border-top: 1px solid #e2e2e2;
    }

    table.colTable tbody td:first-child {
        border-top: none;
    }

    table.colTable.left tbody th {
        text-align: left !important;
        padding-left: 10px;
    }

    .pop_wrapk table.mapTable {
        width: 100%;
        border: 1px solid #ececec;
    }

    .pop_wrapk table.mapTable th {
        background: #f6f6f6;
        border-left: 1px solid #ececec;
    }

    .pop_wrapk table.mapTable th:first-child {
        border-left: none;
    }

    .pop_wrapk table.mapTable td {
        text-align: center;
        border-left: 1px solid #ececec;
        border-top: 1px solid #ececec;
    }


    /* 신재생에너지 */
    .grayBox {
        background: #f8f8f8;
        padding: 15px 10px;
        text-align: center;
    }

    .grayBox.left {
        text-align: left;
    }

    .waList ul li {
        margin-bottom: 15px;
    }

    .wImg {
        float: left;
        margin-right: 30px;
    }

    .listDl.faqM dd a,
    .listDl.faqM dt a strong {
        position: relative;
        font-size: 12px;
    }

    .listDl.faqM dt a span.th01 {
        position: absolute;
        left: -5px;
    }

    .listDl.faqM dt a span.th01 img {
        width: 20px;
        height: 20px;
    }

    .listDl.faqM dt a span.th03 {
        padding-left: 10.15%
    }

    .listDl.faqM dd div.th01 {
        margin-left: 20px;
        width: 25px;
    }

    .listDl.faqM dd div.th01 img {
        width: 20px;
        height: 20px;
    }

    /* 댐주변지역 지원사업 현황 */
    .damImgList {
        overflow: hidden;
        margin-top: 20px;
    }

    .damImgList:after {
        clear: both;
        content: "";
        display: block;
    }

    .damImgList li {
        float: left;
    }

    .damImgList li {
        width: 33%;
    }

    .damImgList li img {
        display: block;
    }

    .damImgList li:first-child {
        width: 34%
    }

    /* 하는일 테이블 */
    .worksTable {
        width: 100%;
        border-top: 1px solid #005596;
        border-bottom: 1px solid #d1d1d1;
        margin-bottom: 25px;
        border-collapse: separate;
        word-break: break-all;
        border-right: 1px solid #ececec;
    }

    .worksTable strong {
        font-weight: bold;
    }

    .worksTable thead th {
        color: #323232;
        font-weight: bold;
        padding: 10px 0;
        background: #f7f8fb;
        border-left: 1px solid #ececec;
    }

    .worksTable thead th:first-child {
        border-left: 1px solid #ececec;
    }

    .worksTable tr th,
    .worksTable tr td {
        border-top: 1px solid #ececec;
        text-align: center;
        vertical-align: middle;
    }

    .worksTable tr td {
        padding: 12px 5px 12px 5px;
    }

    .worksTable tbody th,
    .worksTable tfoot th {
        font-weight: normal;
        vertical-align: middle;
        font-size: 16px;
    }

    .worksTable tbody tr th:first-child {
        border-left: 1px solid #ececec;
        padding-left: 5px;
        padding-right: 5px;
        text-align: center;
    }

    .worksTable tbody tr td {
        border-left: 1px solid #ececec;
        font-size: 14px;
    }

    /*.worksTable tbody tr td:first-child{border-left-width:0}*/
    .worksTable tfoot tr th:first-child {
        border-left: 1px solid #ececec;
        padding-left: 5px;
        padding-right: 5px;
        text-align: center;
    }

    .worksTable tfoot tr td {
        border-left: 1px solid #ececec;
        font-size: 14px;
    }

    .worksTable tfoot tr td:first-child {
        border-left-width: 0
    }

    .worksTable .bdl {
        border-left-width: 1px !important
    }

    /* blit */
    h3.blit {
        background: url('/images/egovframework/renewal/contents/dot_03.gif') 1px 8px no-repeat;
        padding-left: 10px;
        background-size: 3px;
        line-height: 18px;
    }

    p.blit, ul.blit01 > li {
        background: url('/images/egovframework/renewal/contents/dot_03.gif') 1px 10px no-repeat;
        padding-left: 10px;
        background-size: 3px;
        line-height: 22px;
        font-size: 14px;
    }

    ul.blit01 > li.nobg {
        background: none
    }


    /* 리스트 상단 검색 */
    .realtime_topSearch {
        border: 1px solid #f0f0f0;
        padding: 17px 0;
        margin-bottom: 20px;
        background: #f3f7f9;
    }

    .realtime_topSearch .inBox01 {
        float: left;
        width: 82.58%;
        padding-left: 2.83%;
    }

    .realtime_topSearch .inBox02 {
        float: right;
        width: 10.59%;
    }

    .realtime_topSearch .inBox02 input[type=image] {
        width: 73px;
        height: 31px;
    }

    .realtime_topSearch .inBox02 .mobileOff input[type=image] {
        width: 82px;
        height: 74px;
    }

    .realtime_topSearch .inBox01 span {
        display: inline-block;
        text-align: left;
    }

    .realtime_topSearch .inBox01 span.mobileOn {
        display: none;
    }

    .realtime_topSearch .inBox01 span.mobileOff {
        display: inline-block;
    }

    .realtime_topSearch .inBox01 span input,
    .realtime_topSearch .inBox01 span select {
        padding: 7px 0;
        margin: 0;
        border: 1px solid #f2f2f2;
        border-top: 1px solid #b2b2b2;
        line-height: 17px;
        vertical-align: middle
    }

    .realtime_topSearch .inBox01 span input {
        width: 142px !important;
        padding-left: 5px
    }

    .realtime_topSearch .inBox01 span.search01,
    .realtime_topSearch .inBox01 span.search02,
    .realtime_topSearch .inBox01 span.search03 {
        margin-bottom: 5px;
    }

    .realtime_topSearch .inBox01 span.search01 {
        width: 26.45%;
    }

    .realtime_topSearch .inBox01 span.search01 select {
        width: 81.92%;
    }

    .realtime_topSearch .inBox01 span.search02 {
        width: 33.59%;
    }

    .realtime_topSearch .inBox01 span.search02 select {
        width: 63.44%;
    }

    .realtime_topSearch .inBox01 span.search03 {
        width: 28.01%;
    }

    .realtime_topSearch .inBox01 span.search03 select {
        width: 77.07%;
    }

    .realtime_topSearch .inBox01 span.search04 {
        width: 26.45%;
    }

    .realtime_topSearch .inBox01 span.search04 input {
        width: 80.23%;
    }

    .realtime_topSearch .inBox01 span.search05 {
        width: 33.59%;
    }

    .realtime_topSearch .inBox01 span.search05 input {
        width: 62.11%;
    }

    .realtime_topSearch .inBox01 .w3cC {
        margin-left: 5px;
        vertical-align: middle !important
    }

    /* searchForm */
    .searchForm {
        position: relative;
        overflow: hidden;
        padding: 15px !important;
        border: 1px solid #f0f0f0;
        background: #f7f7f7
    }

    .searchForm ul li {
        float: left;
        width: 85%
    }

    .searchForm ul li dl {
        overflow: hidden;
        margin-bottom: 5px
    }

    .searchForm ul li dl:last-child {
        margin-bottom: 0
    }

    .searchForm ul li dl dt {
        float: left;
        width: 20%;
        font-size: 13px;
        color: #494949;
        font-weight: bold;
        line-height: 30px
    }

    .searchForm ul li dl dd {
        float: left;
        width: 70%
    }

    .searchForm ul li dl dd select {
        width: 35%;
        height: 32px;
        border: 1px solid #ddd
    }

    .searchForm ul li dl dd span {
        margin: 0 10px
    }

    .searchForm ul li dl dd input {
        width: 35%;
        height: 28px;
        border: 1px solid #ddd
    }

    .searchForm ul li dl dd .subject_input {
        width: 55%
    }

    .searchForm ul li.R {
        float: right;
        width: 15%;
        margin-top: 15px;
        text-align: right
    }

    .searchForm ul li.R .btn_search_Img {
        display: block
    }

    .searchForm ul li.R .btn_search_mobImg {
        display: none
    }

    /*실시간정보_상수도*/
    .tab_list_line ul li .tip, .tab_list_line ul li .tip span {
        display: block
    }

    .tab_list_line ul li .tip01 {
        display: none;
        position: absolute;
        top: 25px;
        left: 0;
        width: 274px;
        height: 84px;
        background: url("/images/egovframework/renewal/contents/waterqm_tip_bg02.png") no-repeat 0 0;
        padding: 3px 10px;
    }

    .tab_list_line ul li .tip02 {
        display: none;
        position: absolute;
        top: 25px;
        left: 200px;
        width: 274px;
        height: 84px;
        background: url("/images/egovframework/renewal/contents/waterqm_tip_bg02.png") no-repeat 0 0;
        padding: 3px 10px;
    }

    .tab_list_line ul li .tip03 {
        display: none;
        position: absolute;
        top: 25px;
        left: 405px;
        width: 274px;
        height: 84px;
        background: url("/images/egovframework/renewal/contents/waterqm_tip_bg02.png") no-repeat 0 0;
        padding: 3px 10px;
    }

    .tab_list_line ul li .tip04 {
        display: none;
        position: absolute;
        top: 25px;
        left: 610px;
        width: 274px;
        height: 84px;
        background: url("/images/egovframework/renewal/contents/waterqm_tip_bg02.png") no-repeat 0 0;
        padding: 3px 10px;
    }

    .tab_list_line ul li .tip01 span {
        line-height: 17px;
        color: #666;
        font-size: 12px;
        text-align: justify
    }

    .tab_list_line ul li .tip02 span {
        line-height: 17px;
        color: #666;
        font-size: 12px;
        text-align: justify
    }

    .tab_list_line ul li .tip03 span {
        line-height: 17px;
        color: #666;
        font-size: 12px;
        text-align: justify
    }

    .tab_list_line ul li .tip04 span {
        line-height: 17px;
        color: #666;
        font-size: 12px;
        text-align: justify
    }

    .graph_area {
        position: relative;
        padding-top: 15px
    }

    .graph_area .graph_item01, .graph_area .graph_item02 {
        position: absolute;
        font-size: 11px
    }

    .graph_area .graph_item01 {
        top: 27px;
        left: 25px
    }

    .graph_area .graph_item02 {
        bottom: 65px;
        right: 90px
    }

    .graph_area svg {
        overflow: visible !important
    }

    .damsWrap .graphBox {
        width: 100%;
    }

    /**/
    .realtime_topSearch .inBox01 .chk-group {
        display: inline-block;
        margin-left: 10px;
    }

    .realtime_topSearch .inBox01 .chk-group input[type=checkbox ] {
        margin: 0 5px;
        width: auto ! important;
    }

    .damsWrap .worksTable th.ver-top {
        vertical-align: top;
    }

    .check-box span input[type=checkbox] {
        width: auto ! important;
    }

    .check-box {
        display: inline-block;
        margin-left: 9px;
    }

    .realtime_topSearch .inBox01 span input[type="radio"] {
        width: auto ! important;
    }

    .realtime_topSearch .inBox01 span label {
        margin: 0 10px 0 2px;
    }


    /**/
    .ui-jqgrid .ui-jqgrid-htable th div {
        overflow: hidden;
        position: relative;
        display: inline-block;
        height: auto;
        padding: 4px 2px;
        vertical-align: middle;
        white-space: normal !important;
    }

    .main_table {
        border: solid;
        border-width: 0px 0px 0px 0px;
        text-align: center;
        font-size: 9pt;
    }

    .damsWrap .worksTable tr td.layout_td {
        padding: 0 !important;
        vertical-align: top
    }

    .damsWrap .worksTable tr td.layout_td .main_table.bg_header td {
        color: #323232;
        font-weight: bold;
        background: #f7f8fb
    }

    .damsWrap .worksTable tr td.layout_td .main_table.bg_header th {
        color: #323232;
        font-weight: bold;
        background: #f7f8fb;
    }

    .damsWrap .worksTable tr td.layout_td .main_table tbody tr:first-child td {
        border-top-width: 0 !important
    }

    .worksTable tbody tr td.line_no_top td {
        padding: 0;
        line-height: 0;
        border: none !important
    }

    /* 시화호 수문자료 */
    #sihwaList {
        width: 24.9%;
        float: left;
        margin-right: 8px;
    }

    #sihwaList .inBox {
        overflow-y: scroll;
        height: 317px;
    }

    #sihwaGraph {
        width: 74%;
        float: left;
    }

    #sihwaGraph .sihwa {
        padding-right: 1px;
        height: 380px;
    }

    /* 수문자료 우량수위현황 */
    #hydrRainList {
        width: 28.9%;
        float: left;
        margin-right: 8px;
    }

    #hydrRainList .inBox {
        overflow-y: scroll;
        height: 457px;
    }

    #hydrRainGraph {
        width: 70%;
        float: left;
    }

    #hydrRainGraph .rain {
        padding-right: 1px;
        height: 480px;
    }

    /* 수력발전소 발전현황 */
    #versPowerGraph {
        width: 100%;
        height: 440px;
    }

    #versPowerGraph .versChart {
        height: 440px;
        float: left;
        overflow: hidden;
    }

    #versPowerGraph .versChart:nth-child(1) {
        width: 41%;
    }

    #versPowerGraph .versChart:nth-child(2) {
        width: 58%;
        margin-left: 2px;
    }
</style>
<%
    DamDataDTO dto = new DamDataDTO();
    DamDataDAO dao = new DamDataDAO();

    dto = dao.getDamDataDTO();

    String height = dto.getD_height();
    String length = dto.getD_length();
    String altitude = dto.getD_altitude();
    String volume = dto.getD_volume();
    String darea = dto.getD_dArea();
    String suparea = dto.getD_supArea();
    String area = dto.getD_area();
    String fwl = dto.getD_FWL();
    String nwl = dto.getD_NWL();
    String lwl = dto.getD_LWL();
    String maltitude = dto.getD_mAltitude();
    String lowlevelwater = dto.getD_lowLevelWater();
    String tsuparea = dto.getD_tSupArea();
    String valvol = dto.getD_valVol();

    DamStatusDTO dto2 = new DamStatusDTO();
    DamStatusDAO dao2 = new DamStatusDAO();
    dto2 = dao2.getDamStatusDTO();

    ArrayList<DamStatusDTO> list = new ArrayList<DamStatusDTO>();
    list = dao2.getList();

    String s_time = dto2.getS_time();
    String s_lowlevelwater = dto2.getS_lowLevelWater();
    String s_waterstorage = dto2.getS_waterStorage();
    String s_pow = dto2.getS_POW();
    String s_inflow = dto2.getS_inflow();
    String s_esr = dto2.getS_ESR();

%>
<aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3   bg-gradient-dark"
       id="sidenav-main">
    <div class="sidenav-header">
        <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
           aria-hidden="true" id="iconSidenav"></i>
        <a class="navbar-brand m-0" href="#" target="_blank">
            <img src="../assets/img/water-icon.png" class="navbar-brand-img h-100" alt="main_logo">
            <span class="ms-1 font-weight-bold text-white">메뉴</span>
        </a>
    </div>
    <hr class="horizontal light mt-0 mb-2">
    <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link text-white" href="../pages/dashboard.jsp">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">opacity</i>
                    </div>
                    <span class="nav-link-text ms-1">메인</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white active bg-gradient-info" href="../pages/tables.jsp">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">opacity</i>
                    </div>
                    <span class="nav-link-text ms-1">저수지역정보예측수심</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white " href="../pages/billing.jsp">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">opacity</i>
                    </div>
                    <span class="nav-link-text ms-1">저수지역정보예측수심2</span>
                </a>
            </li>
            <li class="nav-item mt-3">
                <h6 class="ps-4 ms-2 text-uppercase text-xs text-white font-weight-bolder opacity-8">계정 관리</h6>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white " href="../pages/sign-in.jsp">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">login</i>
                    </div>
                    <span class="nav-link-text ms-1">Sign In</span>
                </a>
            </li>

        </ul>
    </div>
    <div class="sidenav-footer position-absolute w-100 bottom-0 ">
        <div class="mx-3">
            <a class="btn bg-gradient-info mt-4 w-100" href="#" type="button">닫기</a>
        </div>
    </div>
</aside>
<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">

    <!-- Navbar -->
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur"
         navbar-scroll="true">
        <div class="container-fluid py-1 px-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
                    <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="javascript:(0);">Pages</a>
                    </li>
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">저수지역정보예측수심2</li>
                </ol>
                <h6 class="font-weight-bolder mb-0">저수지역정보예측수심2</h6>
            </nav>
            <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
                <div class="ms-md-auto pe-md-3 d-flex align-items-center">
                    <div class="input-group input-group-outline">
                        <label class="form-label">검색</label>
                        <input type="text" class="form-control">
                    </div>
                </div>
                <ul class="navbar-nav  justify-content-end">
                    <li class="nav-item d-flex align-items-center">
                        <a href="javascript:(0);" class="nav-link text-body font-weight-bold px-0">
                            <i class="fa fa-user me-sm-1"></i>
                            <span class="d-sm-inline d-none">로그인</span>
                        </a>
                    </li>
                    <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-body p-0" id="iconNavbarSidenav">
                            <div class="sidenav-toggler-inner">
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                            </div>
                        </a>
                    </li>
                    <li class="nav-item px-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-body p-0">
                            <i class="fa fa-cog fixed-plugin-button-nav cursor-pointer"></i>
                        </a>
                    </li>
                    <li class="nav-item dropdown pe-2 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-body p-0" id="dropdownMenuButton"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-bell cursor-pointer"></i>
                        </a>
                        <ul class="dropdown-menu  dropdown-menu-end  px-2 py-3 me-sm-n4"
                            aria-labelledby="dropdownMenuButton">
                            <li class="mb-2">
                                <a class="dropdown-item border-radius-md" href="javascript:;">
                                    <div class="d-flex py-1">
                                        <div class="my-auto">
                                            <img src="../assets/img/team-2.jpg" class="avatar avatar-sm  me-3 ">
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="text-sm font-weight-normal mb-1">
                                                <span class="font-weight-bold">New message</span> from Laur
                                            </h6>
                                            <p class="text-xs text-secondary mb-0">
                                                <i class="fa fa-clock me-1"></i>
                                                13 minutes ago
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="mb-2">
                                <a class="dropdown-item border-radius-md" href="javascript:;">
                                    <div class="d-flex py-1">
                                        <div class="my-auto">
                                            <img src="../assets/img/small-logos/logo-spotify.svg"
                                                 class="avatar avatar-sm bg-gradient-dark  me-3 ">
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="text-sm font-weight-normal mb-1">
                                                <span class="font-weight-bold">New album</span> by Travis Scott
                                            </h6>
                                            <p class="text-xs text-secondary mb-0">
                                                <i class="fa fa-clock me-1"></i>
                                                1 day
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item border-radius-md" href="javascript:;">
                                    <div class="d-flex py-1">
                                        <div class="avatar avatar-sm bg-gradient-secondary  me-3  my-auto">
                                            <svg width="12px" height="12px" viewBox="0 0 43 36" version="1.1"
                                                 xmlns="http://www.w3.org/2000/svg"
                                                 xmlns:xlink="http://www.w3.org/1999/xlink">
                                                <title>credit-card</title>
                                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                    <g transform="translate(-2169.000000, -745.000000)" fill="#FFFFFF"
                                                       fill-rule="nonzero">
                                                        <g transform="translate(1716.000000, 291.000000)">
                                                            <g transform="translate(453.000000, 454.000000)">
                                                                <path class="color-background"
                                                                      d="M43,10.7482083 L43,3.58333333 C43,1.60354167 41.3964583,0 39.4166667,0 L3.58333333,0 C1.60354167,0 0,1.60354167 0,3.58333333 L0,10.7482083 L43,10.7482083 Z"
                                                                      opacity="0.593633743"></path>
                                                                <path class="color-background"
                                                                      d="M0,16.125 L0,32.25 C0,34.2297917 1.60354167,35.8333333 3.58333333,35.8333333 L39.4166667,35.8333333 C41.3964583,35.8333333 43,34.2297917 43,32.25 L43,16.125 L0,16.125 Z M19.7083333,26.875 L7.16666667,26.875 L7.16666667,23.2916667 L19.7083333,23.2916667 L19.7083333,26.875 Z M35.8333333,26.875 L28.6666667,26.875 L28.6666667,23.2916667 L35.8333333,23.2916667 L35.8333333,26.875 Z"></path>
                                                            </g>
                                                        </g>
                                                    </g>
                                                </g>
                                            </svg>
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="text-sm font-weight-normal mb-1">
                                                Payment successfully completed
                                            </h6>
                                            <p class="text-xs text-secondary mb-0">
                                                <i class="fa fa-clock me-1"></i>
                                                2 days
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->

    <!-- 배경화면 -->
    <div class="container-fluid px-2 px-md-4">

        <div class="page-header min-height-400 border-radius-xl mt-4"
             style="background-image: url('http://ojsfile.ohmynews.com/STD_IMG_FILE/2022/0617/IE003007580_STD.jpeg');">

            <span class="mask opacity-6"></span>
        </div>
        <div class="card card-body mx-3 mx-md-4 mt-n6">
            <div class="dam_thum_info">
                <p class="thum_area" style="margin-right:15px;">
                    <br>
                    <br>
                    <img src="https://www.water.or.kr/images/egovframework/realtime/web/images/realimage/35.jpg"
                         alt="전경이미지" style="
     padding-left: 20px;"/>
                    <br>
                    <img src=" https://www.water.or.kr/images/egovframework/realtime/web/images/realimage/35_LOC.jpg"
                         alt="위치정보" style="
     padding-left: 20px; "/>
<%--                    <button onclick="predict()">플라스크연동</button>--%>
                </p>


                <table class="worksTable thBold DAMInfo">
                    <colgroup>
                        <col/>
                        <col class="tbl-col-22" span="4"/>
                    </colgroup>
                    <h2 id="title" class="con_title_icon">평림댐 현황</h2>
                    <thead>
                    <tr>
                        <th>구분</th>
                        <td colspan="4">댐 / 평림천 / E.C.R.D</td>
                    </tr>
                    <tr>
                        <th rowspan="2">제원</th>
                        <th>높이 (m)</th>
                        <th>길이 (m)</th>
                        <th>정상표고<br/>(EL.m)</th>
                        <th>체적 (천m<sup>3</sup>)</th>
                    </tr>
                    <tr>
                        <td><%=height%>
                        </td>
                        <td><%=length%>
                        </td>
                        <td><%=altitude%>
                        </td>
                        <td><%=volume%>
                        </td>
                    </tr>
                    <tr>
                        <th rowspan="2">유역</th>
                        <th colspan="2">유역면적 (km<sup>2</sup>)</th>
                        <th colspan="2">연간용수공급용량 (백만m<sup>3</sup>)</th>
                    </tr>
                    <tr>
                        <td colspan="2"><%=darea%>
                        </td>
                        <td colspan="2"><%=suparea%>
                        </td>
                    </tr>
                    <tr>
                        <th rowspan="10">저수지</th>
                        <th colspan="2">저수면적 (km<sup>2</sup>)</th>
                        <th colspan="2">계획홍수위 (EL.m)</th>
                    </tr>
                    <tr>
                        <td colspan="2"><%=area%>
                        </td>
                        <td colspan="2"><%=fwl%>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="2">상시만수위 (EL.m)</th>
                        <th colspan="2">홍수기제한수위 (EL.m)</th>
                    </tr>
                    <tr>
                        <td colspan="2"><%=nwl%>
                        </td>
                        <td colspan="2"><%=lwl%>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="2">월류정표고 (EL.m)</th>
                        <th colspan="2">저수위 (EL.m)</th>
                    </tr>
                    <tr>
                        <td colspan="2"><%=maltitude%>
                        </td>
                        <td colspan="2"><%=lowlevelwater%>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="2">총 저수용량 (백만m<sup>3</sup>)</th>
                        <th colspan="2">유효 저수량 (백만m<sup>3</sup>)</th>
                    </tr>
                    <tr>
                        <td colspan="2"><%=tsuparea%>
                        </td>
                        <td colspan="2"><%=valvol%>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="2">홍수 조절용량 (백만m<sup>3</sup>)</th>
                        <th colspan="2">사업기간</th>
                    </tr>
                    <tr>
                        <td colspan="2"> 0.0</td>
                        <td colspan="2"> ~</td>
                    </tr>
                    </thead>
                </table>

                <table class="worksTable thBold DAMInfo">
                    <colgroup>
                        <col/>
                        <col class="tbl-col-22" span="4"/>
                    </colgroup>
                    <h2 id="title" class="con_title_icon">평림댐 일자별 현황</h2>
                    <thead>
                    <tr>
                        <th>일시</th>
                        <th>수위 (EL.m)</th>
                        <th>저수량 (백만㎥)</th>
                        <th>저수율<br/>(%)</th>
                        <th>유효저수율(%)</th>
                        <th>강우량 (mm)</th>
                        <th>유입량(㎥)</th>
                        <th>총방류량(㎥)</th>
                    </tr>

                        <% for (int i = 0; i < list.size(); i++) {%>
                    <tr>
                        <td><%=list.get(i).getS_time()%>
                        </td>

                        <td><%=list.get(i).getS_lowLevelWater()%>
                        </td>
                        <td><%=list.get(i).getS_waterStorage()%>
                        </td>
                        <td><%=list.get(i).getS_POW()%>
                        </td>
                        <td><%=list.get(i).getS_ESR()%>
                        </td>
                        <td><%=list.get(i).getS_rainfall()%>
                        </td>
                        <td><%=list.get(i).getS_inflow()%>
                        </td>
                        <td><%=list.get(i).getS_tOutflow()%>
                        </td>
                    </tr>
                        <%}%>
                    <tr>
                </table>


                <%--            <div class="bg-gradient-light shadow-card border-radius-lg pt-4 pb-3">--%>
                <%--                <div class="card z-index-2  ">--%>
                <%--                    <div class="card-header p-0 position-relative t-4 pb-3 z-index-2 bg-transparent">--%>
                <%--                        <div class="bg-gradient-white shadow-success border-radius-lg pt-4 pb-3">--%>
                <%--                            빈 공간--%>
                <%--                        </div>--%>
                <%--                    </div>--%>


                <%--                    <div class="row">--%>
                <%--                        <div class="col-12">--%>
                <%--                            <div class="card my-4">--%>
                <%--                                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">--%>
                <%--                                    <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">--%>
                <%--                                        <h6 class="text-white text-capitalize ps-3">Projects table</h6>--%>
                <%--                                    </div>--%>
                <%--                                </div>--%>
                <%--                                <div class="card-body px-0 pb-2">--%>
                <%--                                    <div class="table-responsive p-0">--%>
                <%--                                        <table class="table align-items-center justify-content-center mb-0">--%>
                <%--                                            <thead>--%>
                <%--                                            <tr>--%>
                <%--                                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Project</th>--%>
                <%--                                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Budget</th>--%>
                <%--                                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Status</th>--%>
                <%--                                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Completion</th>--%>
                <%--                                                <th></th>--%>
                <%--                                            </tr>--%>
                <%--                                            </thead>--%>
                <%--                                            <tbody>--%>
                <%--                                            <tr>--%>
                <%--                                                <td>--%>
                <%--                                                    <div class="d-flex px-2">--%>
                <%--                                                        <div>--%>
                <%--                                                            <img src="../assets/img/small-logos/logo-asana.svg" class="avatar avatar-sm rounded-circle me-2" alt="spotify">--%>
                <%--                                                        </div>--%>
                <%--                                                        <div class="my-auto">--%>
                <%--                                                            <h6 class="mb-0 text-sm">Asana</h6>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <p class="text-sm font-weight-bold mb-0">$2,500</p>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <span class="text-xs font-weight-bold">working</span>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle text-center">--%>
                <%--                                                    <div class="d-flex align-items-center justify-content-center">--%>
                <%--                                                        <span class="me-2 text-xs font-weight-bold">60%</span>--%>
                <%--                                                        <div>--%>
                <%--                                                            <div class="progress">--%>
                <%--                                                                <div class="progress-bar bg-gradient-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>--%>
                <%--                                                            </div>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle">--%>
                <%--                                                    <button class="btn btn-link text-secondary mb-0">--%>
                <%--                                                        <i class="fa fa-ellipsis-v text-xs"></i>--%>
                <%--                                                    </button>--%>
                <%--                                                </td>--%>
                <%--                                            </tr>--%>
                <%--                                            <tr>--%>
                <%--                                                <td>--%>
                <%--                                                    <div class="d-flex px-2">--%>
                <%--                                                        <div>--%>
                <%--                                                            <img src="../assets/img/small-logos/github.svg" class="avatar avatar-sm rounded-circle me-2" alt="invision">--%>
                <%--                                                        </div>--%>
                <%--                                                        <div class="my-auto">--%>
                <%--                                                            <h6 class="mb-0 text-sm">Github</h6>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <p class="text-sm font-weight-bold mb-0">$5,000</p>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <span class="text-xs font-weight-bold">done</span>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle text-center">--%>
                <%--                                                    <div class="d-flex align-items-center justify-content-center">--%>
                <%--                                                        <span class="me-2 text-xs font-weight-bold">100%</span>--%>
                <%--                                                        <div>--%>
                <%--                                                            <div class="progress">--%>
                <%--                                                                <div class="progress-bar bg-gradient-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>--%>
                <%--                                                            </div>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle">--%>
                <%--                                                    <button class="btn btn-link text-secondary mb-0" aria-haspopup="true" aria-expanded="false">--%>
                <%--                                                        <i class="fa fa-ellipsis-v text-xs"></i>--%>
                <%--                                                    </button>--%>
                <%--                                                </td>--%>
                <%--                                            </tr>--%>
                <%--                                            <tr>--%>
                <%--                                                <td>--%>
                <%--                                                    <div class="d-flex px-2">--%>
                <%--                                                        <div>--%>
                <%--                                                            <img src="../assets/img/small-logos/logo-atlassian.svg" class="avatar avatar-sm rounded-circle me-2" alt="jira">--%>
                <%--                                                        </div>--%>
                <%--                                                        <div class="my-auto">--%>
                <%--                                                            <h6 class="mb-0 text-sm">Atlassian</h6>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <p class="text-sm font-weight-bold mb-0">$3,400</p>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <span class="text-xs font-weight-bold">canceled</span>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle text-center">--%>
                <%--                                                    <div class="d-flex align-items-center justify-content-center">--%>
                <%--                                                        <span class="me-2 text-xs font-weight-bold">30%</span>--%>
                <%--                                                        <div>--%>
                <%--                                                            <div class="progress">--%>
                <%--                                                                <div class="progress-bar bg-gradient-danger" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="30" style="width: 30%;"></div>--%>
                <%--                                                            </div>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle">--%>
                <%--                                                    <button class="btn btn-link text-secondary mb-0" aria-haspopup="true" aria-expanded="false">--%>
                <%--                                                        <i class="fa fa-ellipsis-v text-xs"></i>--%>
                <%--                                                    </button>--%>
                <%--                                                </td>--%>
                <%--                                            </tr>--%>
                <%--                                            <tr>--%>
                <%--                                                <td>--%>
                <%--                                                    <div class="d-flex px-2">--%>
                <%--                                                        <div>--%>
                <%--                                                            <img src="../assets/img/small-logos/bootstrap.svg" class="avatar avatar-sm rounded-circle me-2" alt="webdev">--%>
                <%--                                                        </div>--%>
                <%--                                                        <div class="my-auto">--%>
                <%--                                                            <h6 class="mb-0 text-sm">Bootstrap</h6>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <p class="text-sm font-weight-bold mb-0">$14,000</p>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <span class="text-xs font-weight-bold">working</span>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle text-center">--%>
                <%--                                                    <div class="d-flex align-items-center justify-content-center">--%>
                <%--                                                        <span class="me-2 text-xs font-weight-bold">80%</span>--%>
                <%--                                                        <div>--%>
                <%--                                                            <div class="progress">--%>
                <%--                                                                <div class="progress-bar bg-gradient-info" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="80" style="width: 80%;"></div>--%>
                <%--                                                            </div>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle">--%>
                <%--                                                    <button class="btn btn-link text-secondary mb-0" aria-haspopup="true" aria-expanded="false">--%>
                <%--                                                        <i class="fa fa-ellipsis-v text-xs"></i>--%>
                <%--                                                    </button>--%>
                <%--                                                </td>--%>
                <%--                                            </tr>--%>
                <%--                                            <tr>--%>
                <%--                                                <td>--%>
                <%--                                                    <div class="d-flex px-2">--%>
                <%--                                                        <div>--%>
                <%--                                                            <img src="../assets/img/small-logos/logo-slack.svg" class="avatar avatar-sm rounded-circle me-2" alt="slack">--%>
                <%--                                                        </div>--%>
                <%--                                                        <div class="my-auto">--%>
                <%--                                                            <h6 class="mb-0 text-sm">Slack</h6>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <p class="text-sm font-weight-bold mb-0">$1,000</p>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <span class="text-xs font-weight-bold">canceled</span>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle text-center">--%>
                <%--                                                    <div class="d-flex align-items-center justify-content-center">--%>
                <%--                                                        <span class="me-2 text-xs font-weight-bold">0%</span>--%>
                <%--                                                        <div>--%>
                <%--                                                            <div class="progress">--%>
                <%--                                                                <div class="progress-bar bg-gradient-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="0" style="width: 0%;"></div>--%>
                <%--                                                            </div>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle">--%>
                <%--                                                    <button class="btn btn-link text-secondary mb-0" aria-haspopup="true" aria-expanded="false">--%>
                <%--                                                        <i class="fa fa-ellipsis-v text-xs"></i>--%>
                <%--                                                    </button>--%>
                <%--                                                </td>--%>
                <%--                                            </tr>--%>
                <%--                                            <tr>--%>
                <%--                                                <td>--%>
                <%--                                                    <div class="d-flex px-2">--%>
                <%--                                                        <div>--%>
                <%--                                                            <img src="../assets/img/small-logos/devto.svg" class="avatar avatar-sm rounded-circle me-2" alt="xd">--%>
                <%--                                                        </div>--%>
                <%--                                                        <div class="my-auto">--%>
                <%--                                                            <h6 class="mb-0 text-sm">Devto</h6>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <p class="text-sm font-weight-bold mb-0">$2,300</p>--%>
                <%--                                                </td>--%>
                <%--                                                <td>--%>
                <%--                                                    <span class="text-xs font-weight-bold">done</span>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle text-center">--%>
                <%--                                                    <div class="d-flex align-items-center justify-content-center">--%>
                <%--                                                        <span class="me-2 text-xs font-weight-bold">100%</span>--%>
                <%--                                                        <div>--%>
                <%--                                                            <div class="progress">--%>
                <%--                                                                <div class="progress-bar bg-gradient-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>--%>
                <%--                                                            </div>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </td>--%>
                <%--                                                <td class="align-middle">--%>
                <%--                                                    <button class="btn btn-link text-secondary mb-0" aria-haspopup="true" aria-expanded="false">--%>
                <%--                                                        <i class="fa fa-ellipsis-v text-xs"></i>--%>
                <%--                                                    </button>--%>
                <%--                                                </td>--%>
                <%--                                            </tr>--%>
                </tbody>
                </table>
            </div>
        </div>
    </div>
    </div>
    </div>
    <footer class="footer py-4  ">
        <div class="container-fluid">
            <div class="row align-items-center justify-content-lg-between">
                <div class="col-lg-6 mb-lg-0 mb-4">
                    <div class="copyright text-center text-sm text-muted text-lg-start">
                        <br>
                        ©
                        <script>
                            document.write(new Date().getFullYear())
                        </script>
                        ,
                        Project made by
                        <a href="https://www.netflix.com" class="font-weight-bold" target="_blank"> 김강훈</a>
                        , 최낙현, 황인성, 최석재, 정세빈
                    </div>
                </div>
                <%--                <div class="col-lg-6">--%>
                <%--                    <ul class="nav nav-footer justify-content-center justify-content-lg-end">--%>
                <%--                        <li class="nav-item">--%>
                <%--                            <a href="https://www.creative-tim.com" class="nav-link text-muted" target="_blank">Creative--%>
                <%--                                Tim</a>--%>
                <%--                        </li>--%>
                <%--                        <li class="nav-item">--%>
                <%--                            <a href="https://www.creative-tim.com/presentation" class="nav-link text-muted"--%>
                <%--                               target="_blank">About Us</a>--%>
                <%--                        </li>--%>
                <%--                        <li class="nav-item">--%>
                <%--                            <a href="https://www.creative-tim.com/blog" class="nav-link text-muted"--%>
                <%--                               target="_blank">Blog</a>--%>
                <%--                        </li>--%>
                <%--                        <li class="nav-item">--%>
                <%--                            <a href="https://www.creative-tim.com/license" class="nav-link pe-0 text-muted"--%>
                <%--                               target="_blank">License</a>--%>
                <%--                        </li>--%>
                <%--                    </ul>--%>
                <%--                </div>--%>
            </div>
        </div>
    </footer>
    </div>
</main>
<div class="fixed-plugin">
    <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
        <i class="material-icons py-2">settings</i>
    </a>
    <div class="card shadow-lg">
        <div class="card-header pb-0 pt-3">
            <div class="float-start">
                <h5 class="mt-3 mb-0">Material UI Configurator</h5>
                <p>See our dashboard options.</p>
            </div>
            <div class="float-end mt-4">
                <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
                    <i class="material-icons">clear</i>
                </button>
            </div>
            <!-- End Toggle Button -->
        </div>
        <hr class="horizontal dark my-1">
        <div class="card-body pt-sm-3 pt-0">
            <!-- Sidebar Backgrounds -->
            <div>
                <h6 class="mb-0">Sidebar Colors</h6>
            </div>
            <a href="javascript:void(0)" class="switch-trigger background-color">
                <div class="badge-colors my-2 text-start">
                    <span class="badge filter bg-gradient-primary active" data-color="primary"
                          onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-dark" data-color="dark" onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-info" data-color="info" onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-success" data-color="success"
                          onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-warning" data-color="warning"
                          onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-danger" data-color="danger"
                          onclick="sidebarColor(this)"></span>
                </div>
            </a>
            <!-- Sidenav Type -->
            <div class="mt-3">
                <h6 class="mb-0">Sidenav Type</h6>
                <p class="text-sm">Choose between 2 different sidenav types.</p>
            </div>
            <div class="d-flex">
                <button class="btn bg-gradient-dark px-3 mb-2 active" data-class="bg-gradient-dark"
                        onclick="sidebarType(this)">Dark
                </button>
                <button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-transparent"
                        onclick="sidebarType(this)">Transparent
                </button>
                <button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-white" onclick="sidebarType(this)">
                    White
                </button>
            </div>
            <p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>
            <!-- Navbar Fixed -->
            <div class="mt-3 d-flex">
                <h6 class="mb-0">Navbar Fixed</h6>
                <div class="form-check form-switch ps-0 ms-auto my-auto">
                    <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed"
                           onclick="navbarFixed(this)">
                </div>
            </div>
            <hr class="horizontal dark my-3">
            <div class="mt-2 d-flex">
                <h6 class="mb-0">Light / Dark</h6>
                <div class="form-check form-switch ps-0 ms-auto my-auto">
                    <input class="form-check-input mt-1 ms-auto" type="checkbox" id="dark-version"
                           onclick="darkMode(this)">
                </div>
            </div>
            <hr class="horizontal dark my-sm-4">
            <a class="btn bg-gradient-info w-100" href="https://www.creative-tim.com/product/material-dashboard">Free
                Download</a>
            <a class="btn btn-outline-dark w-100"
               href="https://www.creative-tim.com/learning-lab/bootstrap/overview/material-dashboard">View
                documentation</a>
            <div class="w-100 text-center">
                <a class="github-button" href="https://github.com/creativetimofficial/material-dashboard"
                   data-icon="octicon-star" data-size="large" data-show-count="true"
                   aria-label="Star creativetimofficial/material-dashboard on GitHub">Star</a>
                <h6 class="mt-3">Thank you for sharing!</h6>
                <a href="https://twitter.com/intent/tweet?text=Check%20Material%20UI%20Dashboard%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fsoft-ui-dashboard"
                   class="btn btn-dark mb-0 me-2" target="_blank">
                    <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
                </a>
                <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/material-dashboard"
                   class="btn btn-dark mb-0 me-2" target="_blank">
                    <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
                </a>
            </div>
        </div>
    </div>
</div>
<!--   Core JS Files   -->
<script src="../assets/js/core/popper.min.js"></script>
<script src="../assets/js/core/bootstrap.min.js"></script>
<script src="../assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="../assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
        var options = {
            damping: '0.5'
        }
        Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
</script>

<!-- Github buttons -->

<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="../assets/js/material-dashboard.min.js?v=3.0.2"></script>
<script>
    function predict() {
        $.ajax({
            url: 'http://127.0.0.1:5000/predict',
            type: 'POST',
            data: {'name': 13579},
            dataType: "json",
            success: function () {
                console.log('hihi')

            },
            error: function () {
                console.log('error');
            }
        })
    }

</script>
</body>


</html>
