const express = require('express');
const router = express.Router();
const puppeteer = require('puppeteer');

/* GET home page. */
router.get('/', function(req, res, next) {
  // async function main() {
  //   const browser = await puppeteer.launch(); // ❶ 헤드리스 브라우저 실행
  //   const page = await browser.newPage();     // ❷ 브라우저에 새 페이지 생성
  //
  //   const pageUrl = 'https://www.water.or.kr/realtime/sub01/sub01/dam/hydr.do?s_mid=1323&seq=1408&p_group_seq=1407&menu_mode=3&damcd=5002201';
  //   await page.goto(pageUrl, {
  //     // domcontentloaded : 메인 HTML이 로드되어 DOM이 생성된 순간까지 기다립니다. 포함된 리소스의 로드는 기다리지 않기 때문에 찾는 내용이 메인 HTML 자체에 존재하는 경우 유용합니다.
  //     // load : 메인 HTML과 포함된 자바스크립트, CSS, 이미지 등 모든 리소스가 로드될 때까지 기다립니다.
  //     // networkidle0 : 최소 500ms 동안 활성화된 네트워크 연결이 완전히 없어질 때까지 기다립니다. 자바스크립트를 사용한 API 요청이 있는 페이지에 유용합니다.
  //     // networkidle2 : 최소 500ms 동안 활성화된 네트워크 연결이 2개 이하로 유지될 때까지 기다립니다. 웹페이지 로드가 완료된 이후에도 주기적으로 정보를 업데이트하는 등 폴링 방식으로 구현된 웹페이지에 적용하면 유용합니다.
  //     waitUntil: 'load',
  //   });
  //
  //   // // ➍ 제목/내용 불러오기 버튼을 클릭
  //   // await page.click('input[type="button"]');
  //   //
  //   // await page.waitForFunction(() => {
  //   //   // ➎ 함수가 웹브라우저의 컨텍스트에서 실행되기 때문에 document 객체에 접근 가능
  //   //   return document.getElementById('tui-grid-cell-content').textContent.length > 0;
  //   // });
  //
  //   // ➏ 특정 셀렉터에 대해 제공된 함수를 수행한 값 반환
  //   const content = await page.$eval(
  //       '.tui-grid-cell-content',
  //       (elements) => elements[0].textContent,
  //   );
  //
  //   console.log(content);
  //   await browser.close(); // ➐ 작업이 완료되면 브라우저 종료
  // }

  main();

  res.render('index', { title: 'Express' });
});

module.exports = router;
