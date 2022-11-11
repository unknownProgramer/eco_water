const cal_date = new Date('2022-11-05');

function leftPad(value) {
    if (value >= 10) {
        return value;
    }

    return `0${value}`;
}

function toStringByFormatting(source, delimiter = '-') {
    const year = source.getFullYear();
    const month = leftPad(source.getMonth() + 1);
    const day = leftPad(source.getDate());

    return [year, month, day].join(delimiter);
}

let date_list = [];
for (let i = 1 ; i < 6 ; i++) {
    let result_date;
    cal_date.setDate(cal_date.getDate() + 7);
    result_date = toStringByFormatting(cal_date);
    date_list.push(result_date);
}
console.log(date_list);