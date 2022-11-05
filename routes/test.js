const XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest;
const DOMParser = require('dom-parser');

const xhr = new XMLHttpRequest();
const url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst'; /*URL*/
let queryParams = '?' + encodeURIComponent('serviceKey') + '='+'aCs1kGLS2Mh2wNOCgLD4I%2F6Ik5FrsGqelp6sfs6QQXFBNZIfX20PeOiqelkvYd5E5fiCD8mS25RMd9oH6KKvbA%3D%3D'; /*Service Key*/
queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('1000'); /**/
queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('XML'); /**/
queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent('20221029'); /**/
queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent('0600'); /**/
queryParams += '&' + encodeURIComponent('nx') + '=' + encodeURIComponent('35'); /**/
queryParams += '&' + encodeURIComponent('ny') + '=' + encodeURIComponent('127'); /**/
xhr.open('GET', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        const data = this.responseText; // text 형태로 변환
        let parser = new DOMParser();
        let xmlDoc = parser.parseFromString(data, "text/xml");
        let list = [];
        for ( let i = 0 ; i < 10 ; i ++ ) {
            let one_list = []
            try {
                one_list.push(xmlDoc.getElementsByTagName("baseDate")[i].textContent);
                one_list.push(xmlDoc.getElementsByTagName("baseTime")[i].textContent);
                one_list.push(xmlDoc.getElementsByTagName("category")[i].textContent);
                // one_list.push(xmlDoc.getElementsByTagName("fcstDate")[i].textContent);
                // one_list.push(xmlDoc.getElementsByTagName("fcstTime")[i].textContent);
                // one_list.push(xmlDoc.getElementsByTagName("fcstValue")[i].textContent);
                list.push(one_list);
            } catch {
                break;
            }
            console.log(list);
        }
    }
};
// 단기예보
// POP	강수확률	%	8
// PTY	강수형태	코드값	4
// PCP	1시간 강수량	범주 (1 mm)	8
// REH	습도	%	8
// SNO	1시간 신적설	범주(1 cm)	8
// SKY	하늘상태	코드값	4
// TMP	1시간 기온	℃	10
// TMN	일 최저기온	℃	10
// TMX	일 최고기온	℃	10
// UUU	풍속(동서성분)	m/s	12
// VVV	풍속(남북성분)	m/s	12
// WAV	파고	M	8
// VEC	풍향	deg	10
// WSD	풍속	m/s	10

xhr.send('');