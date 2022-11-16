const express = require('express');
const router = express.Router();
const XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest;
const DOMParser = require('dom-parser');

router.get('/', function(req, res) {
   res.render('info');
});

router.get('/search', function(req, res) {
    const index = req.query.index;
    const cal = (index-1) * 10;

    // 로직 : 10일 구간의 데이터를 가져와야 함.
    //       예를들어, 10월 1일부터 10월 10일까지의 데이터를 가져오려면 검색일자가 10월 1일(검색 시작일자) ~ 10월 11일(검색 종료일자)이 되어야 총 10개의 데이터를 불러올 수 있다.
    //       페이지에 보여지는 데이터는 총 10개. 페이지네이션에서 클릭한 index 값을 불러와 구간을 설정할 수 있음.
    //       예를들어, index 값이 1 이라면 현재 날짜로 부터 10일 전의 데이터를 불러와야 하고, 2라면 10일 전 데이터부터 20일 전 데이터까지 불러와야 한다.
    //       구간이 (n * 10) ~ ((n * 10) - 10) 이기 때문에 cal 변수에 기준이 되는 날을 넣고, 전달받은 index 값은 1부터 시작하기 때문에 -1 을 해준다.
    //       -1 을 한 이유는, 로직상 10을 곱해주면서 페이지마다 구간을 설정해 줘야 하는데, 화면상에 보이는 index 가 1부터 시작해서 만일 1을 빼지 않고 로직을 실행했을 경우
    //       화면상 페이지는 1번이지만 로직상 (1 * 10) ~ ((1 * 10)-10) 이 되어 10일 전 데이터부터 20일 전 데이터 까지 나오기 때문.

    // 검색 종료 일자
    let date = new Date();
    date.setDate(date.getDate() - cal);
    let now_year = date.getFullYear();
    let now_month = ('0' + (date.getMonth() + 1)).slice(-2);
    let now_day = ('0' +( date.getDate() + (index-1))).slice(-2);
    let today = now_year  + now_month  + now_day; // yyyy.mm.dd

    // 검색 시작 일자
    date.setDate(date.getDate() - 10);
    let search_year = date.getFullYear();
    let search_month = ('0' + (date.getMonth() + 1)).slice(-2);
    let search_day = ('0' + date.getDate()).slice(-2);
    let search_that_day = search_year + search_month + search_day; // yyyy.mm.dd
    console.log('검색일자 : '+ today + ' ~ '+ search_that_day);

    const xhr = new XMLHttpRequest();
    const url = 'http://apis.data.go.kr/B500001/drghtDamOper/operInfoList'; /*URL*/

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
            for ( let i = 0 ; i < 10 ; i ++ ) {
                let one_list = []
                try {
                    one_list.push(xmlDoc.getElementsByTagName("obsymd")[i].textContent);
                    one_list.push(xmlDoc.getElementsByTagName("lwl")[i].textContent);
                    one_list.push((xmlDoc.getElementsByTagName("rsqty")[i].textContent)*1000);
                    one_list.push(xmlDoc.getElementsByTagName("iqty")[i].textContent);
                    one_list.push(xmlDoc.getElementsByTagName("rsrt")[i].textContent);
                    list.push(one_list);
                } catch {
                    break;
                }
            }
            list.reverse();
            res.send( {
                data : list,
                index : index
            });
        }
    };
    xhr.send('');
});


module.exports = router;