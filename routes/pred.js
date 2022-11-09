const express = require('express');
const router = express.Router();
const XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest;
const DOMParser = require('dom-parser');

router.get('/', function(req, res, next) {
    res.render('pred');
});

router.get('/search', function (req, res) {
    const xhr = new XMLHttpRequest();
    const url = 'http://apis.data.go.kr/B500001/drghtDamOper/operInfoList'; /*URL*/
    const that_date = req.query.date;

    // 날짜 구하기
    let date = new Date();
    let now_year = date.getFullYear();
    let now_month = ('0' + (date.getMonth() + 1)).slice(-2);
    let now_day = ('0' + date.getDate()).slice(-2);
    let today = now_year  + now_month  + now_day;

    date.setDate(date.getDate() - 10);
    let search_year = date.getFullYear();
    let search_month = ('0' + (date.getMonth() + 1)).slice(-2);
    let search_day = ('0' + date.getDate()).slice(-2);
    let search_that_day = search_year + search_month + search_day;
    console.log('검색일자 : '+ today + ' ~ '+ search_that_day);

    let queryParams = '?' + encodeURIComponent('serviceKey') + '='+'aCs1kGLS2Mh2wNOCgLD4I%2F6Ik5FrsGqelp6sfs6QQXFBNZIfX20PeOiqelkvYd5E5fiCD8mS25RMd9oH6KKvbA%3D%3D'; /*Service Key*/

    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); // 페이지 번호
    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); // 한 페이지의 결과 수
    queryParams += '&' + encodeURIComponent('damCd') + '=' + encodeURIComponent('5002201'); // 댐 코드 (평림댐 : 5002201)
    queryParams += '&' + encodeURIComponent('stDt') + '=' + encodeURIComponent(search_that_day); // 댐 운영 검색 시작 일자
    queryParams += '&' + encodeURIComponent('edDt') + '=' + encodeURIComponent(today); // 댐 운영 검색 종료 일자

    xhr.open('GET', url + queryParams);
    xhr.onreadystatechange = function () {
        if (this.readyState == 4) {
            // this : 댐 데이터 객체
            const data = this.responseText; // text 형태로 변환
            let parser = new DOMParser();
            let xmlDoc = parser.parseFromString(data, "text/xml");
            let list = [];
            try{
                list.push(xmlDoc.getElementsByTagName("lwl")[0].textContent);
                list.push((xmlDoc.getElementsByTagName("rsqty")[0].textContent)*1000);
                list.push(xmlDoc.getElementsByTagName("lwl")[9].textContent);
                list.push((xmlDoc.getElementsByTagName("rsqty")[9].textContent)*1000);
            }catch{}

            console.log(list[0]);
            console.log(list[1]);

            const cal_ELm = list[0] * 1;
            const cal_rsqty = list[1] * 1;

            const month_Elm = [];
            const month_rsqty = [];
            const year_Elm = [];
            const year_rsqty = [];

            const year_Elm_start = [0, 0.3, 0.4, 0.5, 0.7, 0.9, 1.1, 0.9, 0.7, 0.5, 0.3, 0];
            const year_rsqty_start = [0, 300, 500, 700, 1100, 700, 500, 700, 500, 300, 300, 0];

            let month_rand_list_Elm = [];
            for (let i = 1; i < 6; i++) {
                let rand_int = ((Math.floor(Math.random() * 10) + i) + (i * 5)) / 100;
                month_rand_list_Elm.push(rand_int);
            }

            let month_rand_list_rsqty = [];
            for (let i = 1; i < 6; i++) {
                let rand_int = (Math.floor(Math.random() * 25) + i) + (i * 25);
                month_rand_list_rsqty.push(rand_int);
            }

            let year_rand_list_Elm = [];
            for (let i = 1; i < 13; i++) {
                let rand_int = ((Math.floor(Math.random() * 100))) / 100;
                year_rand_list_Elm.push(rand_int);
            }

            let year_rand_list_rsqty = [];
            for (let i = 1; i < 13; i++) {
                let rand_int = (Math.floor(Math.random() * 100) + 100);
                year_rand_list_rsqty.push(rand_int);
            }

            if ( cal_ELm > list[2] ){
                for (let i = 0; i < 5 ; i ++ ){
                    month_Elm.push(cal_ELm + month_rand_list_Elm[i]);
                }
            }else {
                for (let i = 0; i < 5 ; i ++ ){
                    month_Elm.push(cal_ELm - month_rand_list_Elm[i]);
                }
            }

            if (cal_rsqty > list[3]){
                for (let i = 0; i < 5 ; i ++ ){
                    month_rsqty.push(cal_rsqty + month_rand_list_rsqty[i]);
                }
            }else {
                for (let i = 0; i < 5 ; i ++ ){
                    month_rsqty.push(cal_rsqty - month_rand_list_rsqty[i]);
                }
            }

            for (let i = 0 ; i < 12 ; i ++ ){
                year_Elm.push(cal_ELm + year_rand_list_Elm[i] - year_Elm_start[i]);
            }
            for (let i = 0 ; i < 12 ; i ++ ){
                year_rsqty.push(cal_rsqty + year_rand_list_rsqty[i] - year_rsqty_start[i]);
            }

            console.log(month_Elm);
            console.log(month_rsqty);
            console.log(year_Elm);
            console.log(year_rsqty);

            res.send({
                data : list,
                that_date : that_date,
                month_Elm : month_Elm,
                month_rsqty : month_rsqty,
                year_Elm : year_Elm,
                year_rsqty : year_rsqty
            });
        }
    };
    xhr.send('');
})

module.exports = router;