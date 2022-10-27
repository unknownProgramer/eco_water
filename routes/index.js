const express = require('express');
const router = express.Router();
const XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest;
const DOMParser = require('dom-parser');

router.get('/', function(req, res, next) {

  const xhr = new XMLHttpRequest();
  const url = 'http://apis.data.go.kr/B500001/drghtDamOper/operInfoList'; /*URL*/

  // 날짜 구하기
  let date = new Date();
  let now_year = date.getFullYear();
  let now_month = ('0' + (date.getMonth() + 1)).slice(-2);
  let now_day = ('0' + date.getDate()).slice(-2);
  let today = now_year  + now_month  + now_day;

  date.setDate(date.getDate() - 7);
  let search_year = date.getFullYear();
  let search_month = ('0' + (date.getMonth() + 1)).slice(-2);
  let search_day = ('0' + date.getDate()).slice(-2);
  let search_that_day = search_year + search_month + search_day;

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
      // let count =  xmlDoc.getElementsByTagName("totalCount")[0].textContent;// javaScript 의 자동 형변환 이용 => 문자열에 숫자 곱하면 숫자됨
      let list = [];
      for ( let i = 0 ; i < 7 ; i ++) {
        let one_list = []
        try{
          one_list.push(xmlDoc.getElementsByTagName("obsymd")[i].textContent);
          one_list.push(xmlDoc.getElementsByTagName("lwl")[i].textContent);
          one_list.push((xmlDoc.getElementsByTagName("rsqty")[i].textContent)*1000000);
          one_list.push(xmlDoc.getElementsByTagName("iqty")[i].textContent);
          one_list.push(xmlDoc.getElementsByTagName("rsrt")[i].textContent);
          list.push(one_list);
        }catch{
          break;
        }
      }
      res.render('index', {
        data : list,
        today : today
      });
    }
  };
  xhr.send('');
});

module.exports = router;
