let date = new Date();
let now_year = date.getFullYear();
let now_month = ('0' + (date.getMonth() + 1)).slice(-2);
let now_day = ('0' + date.getDate()).slice(-2);
let today = now_year  + now_month  + now_day;
console.log('현재 : ' + today);
console.log('년 : ' + now_year);
console.log('월 : ' + now_month);
console.log('일 : ' + now_day);

date.setDate(date.getDate() - 10);
let to_year = date.getFullYear();
let to_month = ('0' + (date.getMonth() + 1)).slice(-2);
let to_day = ('0' + date.getDate()).slice(-2);
let hundred_day_ago = to_year + to_month + to_day;

console.log('100일 후 : ' + hundred_day_ago);
console.log('년 : ' + to_year);
console.log('월 : ' + to_month);
console.log('일 : ' + to_day);
