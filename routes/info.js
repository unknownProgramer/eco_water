const express = require('express');
const router = express.Router();
const XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest;
const DOMParser = require('dom-parser');

router.get('/', function(req, res, next) {
const xhr = new XMLHttpRequest();
const url = 'http://apis.data.go.kr/B500001/drghtDamOper/operInfoList'; /*URL*/

let date = new Date();
let year = date.getFullYear();
let month = ('0' + (date.getMonth() + 1)).slice(-2);
let day = ('0' + date.getDate()).slice(-2);
let from_day = ('0' + (date.getDate() - 9)).slice(-2);
let today = year  + month  + day;
let ten_day_ago = year + month + from_day;

let queryParams = '?' + encodeURIComponent('serviceKey') + '='+'aCs1kGLS2Mh2wNOCgLD4I%2F6Ik5FrsGqelp6sfs6QQXFBNZIfX20PeOiqelkvYd5E5fiCD8mS25RMd9oH6KKvbA%3D%3D'; /*Service Key*/

queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); // 페이지 번호
queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); // 한 페이지의 결과 수
queryParams += '&' + encodeURIComponent('damCd') + '=' + encodeURIComponent('5002201'); // 댐 코드 (평림댐 : 5002201)
queryParams += '&' + encodeURIComponent('stDt') + '=' + encodeURIComponent(ten_day_ago); // 댐 운영 검색 시작 일자
queryParams += '&' + encodeURIComponent('edDt') + '=' + encodeURIComponent(today); // 댐 운영 검색 종료 일자

xhr.open('GET', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        console.log('-'.repeat(25) + '\nStatus: '+this.status+'\n데이터 응답성공\n'+ '-'.repeat(25));

        // this : 댐 데이터 객체
        const data = this.responseText; // text 형태로 변환
        let parser = new DOMParser();
        let xmlDoc = parser.parseFromString(data, "text/xml");
        // let count =  xmlDoc.getElementsByTagName("totalCount")[0].textContent;// javaScript 의 자동 형변환 이용 => 문자열에 숫자 곱하면 숫자됨
        let list = [];
        for ( let i = 0 ; i < 9 ; i ++ ) {
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
        res.render('info', {
            data : list,
            today : today
        });
    }
};
xhr.send('');
});

router.get('/search', function(req, res, next) {
    const index = req.body.index;
    const xhr = new XMLHttpRequest();
    const url = 'http://apis.data.go.kr/B500001/drghtDamOper/operInfoList'; /*URL*/

    let date = new Date();
    let year = date.getFullYear();
    let month = ('0' + (date.getMonth() + 1)).slice(-2);
    let day = ('0' + date.getDate()).slice(-2);
    let from_year = date.getFullYear() - 1;
    let today = year  + month  + day;
    let one_year_ago = from_year + month + day;

    let queryParams = '?' + encodeURIComponent('serviceKey') + '='+'aCs1kGLS2Mh2wNOCgLD4I%2F6Ik5FrsGqelp6sfs6QQXFBNZIfX20PeOiqelkvYd5E5fiCD8mS25RMd9oH6KKvbA%3D%3D'; /*Service Key*/

    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); // 페이지 번호
    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('365'); // 한 페이지의 결과 수
    queryParams += '&' + encodeURIComponent('damCd') + '=' + encodeURIComponent('5002201'); // 댐 코드 (평림댐 : 5002201)
    queryParams += '&' + encodeURIComponent('stDt') + '=' + encodeURIComponent(one_year_ago); // 댐 운영 검색 시작 일자
    queryParams += '&' + encodeURIComponent('edDt') + '=' + encodeURIComponent(today); // 댐 운영 검색 종료 일자

    xhr.open('GET', url + queryParams);
    xhr.onreadystatechange = function () {
        if (this.readyState == 4) {
            console.log('-'.repeat(25) + '\nStatus: '+this.status+'\n데이터 응답성공\n'+ '-'.repeat(25));

            // this : 댐 데이터 객체
            const data = this.responseText; // text 형태로 변환
            let parser = new DOMParser();
            let xmlDoc = parser.parseFromString(data, "text/xml");
            // let count =  xmlDoc.getElementsByTagName("totalCount")[0].textContent;// javaScript 의 자동 형변환 이용 => 문자열에 숫자 곱하면 숫자됨
            let list = [];
            for ( let i = (index * 10) ; i < ((index * 10) + 10) ; i ++ ) {
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
            res.render('info', {
                data : list,
                today : today,
                index : index
            });
        }
    };
    xhr.send('');
});


module.exports = router;