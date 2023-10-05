const express = require('express');
const router = express.Router();
const fs = require('fs');
const csv = require('csv-parser');

router.get('/', function (req, res) {

   // 수질예측정보 csv 불러오기
   const csvFilePath = './result.csv';
   const jsonData = [];
   let set_color;
   let set_status;
   let preditResult;

   fs.createReadStream(csvFilePath)
      .pipe(csv())
      .on('data', (row) => {
         jsonData.push(row); // JSON 데이터를 jsonData 배열에 추가
      })
      .on('end', () => {

         // 오늘 날짜를 얻습니다.
         const today = new Date().toISOString().split('T')[0]; // yyyy-mm-dd 형태로 얻음

         // 현재 날짜와 가장 가까운 이전 날짜를 찾습니다.
         let closestDate = null;
         let closestDateDiff = Infinity;
         for (const item of jsonData) {
            const date = item.date;
            const dateDiff = Math.abs(new Date(date) - new Date(today));
            if (dateDiff < closestDateDiff) {
               closestDateDiff = dateDiff;
               closestDate = date;
            }
         }

         if (closestDate) {
            // 가장 가까운 이전 날짜를 찾았으면 해당 날짜의 데이터를 사용합니다.
            const closestData = jsonData.find(item => item.date === closestDate);
            preditResult = parseFloat(closestData.predit_result);

            // predit_result 값을 기반으로 색상을 결정합니다.
            if (preditResult < 15) {
               set_color = '#00FF00';
               set_status = '정상';
            } else if (preditResult < 25) {
               set_color = '#FFA500';
               set_status = '경계';
            } else if (preditResult < 50) {
               set_color = '#FF0000';
               set_status = '발생';
            } else {
               set_color = '#800080';
               set_status = '대발생';
            }
         } else {
            console.log('이전 날짜 데이터를 찾을 수 없습니다.');
         }

         // set_color 값을 사용하여 렌더링합니다.
         res.render('prediction', {
            color: set_color,
            status: set_status,
            predit_result: preditResult
         });
      })
      .on('error', (err) => {
         // 오류 처리
         console.error('오류 발생:', err);
      });
});

router.get('/search', function (req, res) {

   // 수질예측정보 csv 불러오기
   const csvFilePath = './result.csv';
   const jsonData = [];
   let futureDataArray = [];
   let preditResult;
   let predition_date = req.query.date;

   fs.createReadStream(csvFilePath)
      .pipe(csv())
      .on('data', (row) => {
         jsonData.push(row); // JSON 데이터를 jsonData 배열에 추가
      })
      .on('end', () => {

         // 현재 날짜와 가장 가까운 이전 날짜 탐색
         let closestDate = null;
         let closestDateDiff = Infinity;
         for (const item of jsonData) {
            const date = item.date;
            const dateDiff = Math.abs(new Date(date) - new Date(predition_date));
            if (dateDiff < closestDateDiff) {
               closestDateDiff = dateDiff;
               closestDate = date;
            }
         }
         
         const startDate = new Date(closestDate);
         if (closestDate) {

            // 가장 가까운 이전 날짜를 찾았으면 해당 날짜의 데이터를 사용
            const closestData = jsonData.find(item => item.date === closestDate);
            preditResult = parseFloat(closestData.predit_result);
            
            for (let i = 0; i < 4; i++) {
               const futureDate = new Date(startDate);
               futureDate.setDate(startDate.getDate() + i * 7); // 1주일 간격으로 계산
            
               const futureDateString = futureDate.toISOString().split('T')[0]; // yyyy-mm-dd 형식으로 변환
            
               const futureDataItem = {
                  date: futureDateString,
                  status: '',
                  preditResult: 0
               };
            
               // preditResult 값을 기반으로 색상과 상태 설정
               preditResult = parseFloat(jsonData.find(item => item.date === futureDateString)?.predit_result);
               if (!isNaN(preditResult)) {
                  if (preditResult < 15) {
                     futureDataItem.status = '정상';
                  } else if (preditResult < 25) {
                     futureDataItem.status = '경계';
                  } else if (preditResult < 50) {
                     futureDataItem.status = '발생';
                  } else {
                     futureDataItem.status = '대발생';
                  }
                  futureDataItem.preditResult = preditResult;
               }
            
               futureDataArray.push(futureDataItem);
            }
         } else {
            console.log('이전 날짜 데이터를 찾을 수 없습니다.');
         }

         res.json(futureDataArray)
      })
      .on('error', (err) => {
         // 오류 처리
         console.error('오류 발생:', err);
      });
});

module.exports = router;
