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
         // 모든 데이터를 성공적으로 읽었을 때
         console.log('CSV 데이터를 JSON으로 변환 완료.');

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

            console.log(`가장 가까운 이전 날짜(${closestDate})의 색상은 ${set_color} 입니다.`);
         } else {
            console.log('이전 날짜 데이터를 찾을 수 없습니다.');
         }

         // set_color 값을 사용하여 렌더링합니다.
         res.render('prediction', {
            color : set_color,
            status : set_status,
            predit_result : preditResult
         });
      })
      .on('error', (err) => {
         // 오류 처리
         console.error('오류 발생:', err);
      });
});

module.exports = router;
