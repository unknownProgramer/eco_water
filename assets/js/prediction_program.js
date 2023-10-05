async function prediction_operation() {
    const prediction_date = $('#datepicker').val();
    const chk_date = new Date();
    const chk_date_limit = new Date();
    const chk_date_from = new Date(prediction_date);
    chk_date_limit.setDate(chk_date.getDate() + 365);

    if (chk_date > chk_date_from) {
        alert('예측 시작날짜는 오늘, 과거가 될 수 없습니다.');
        return;
    }

    const load_pred = $('#load_pred');
    load_pred.empty();
    load_pred.append('학습모델 실행중...');
    await $.ajax({
        url: '/prediction/search',
        type: 'GET',
        data: {
            date: prediction_date
        },
        dataType: "json",
        timeout: 10000,
        contentType: "application/json",
        success: function (data) {
            setTimeout(() => {
                load_pred.empty();

                // 데이터 그리기
                const contents = $('#contents');
                contents.empty();
                let cnt = 0;
                for (let i = 0; i < 4; i++) {
                    contents.append('<tr>' +
                        '<td>' + data[i].date + '</td>' +
                        '<td id="setting_color' + i + '"><b>' + data[i].status + '</b></td>' +
                        '<td>' + data[i].preditResult + '</td>' +
                        '</tr>');
                    let value_cnt = 'setting_color' + i;
                    const setting_color = document.getElementById(value_cnt);
                    if (data[i].status === '정상') {
                        setting_color.style.color = '#00FF00';
                    } else if (data[i].status === '경계') {
                        setting_color.style.color = '#FFA500';
                        cnt = 1;
                    } else if (data[i].status === '발생') {
                        setting_color.style.color = '#FF0000';
                        cnt = 2;
                    } else {
                        setting_color.style.color = '#800080';
                        cnt = 3;
                    }
                }

                if (cnt === 0) {
                    init_color = '#D4F4FA';
                } else if (cnt === 1) {
                    init_color = '#B7F0B1';
                } else if (cnt === 2) {
                    init_color = '#47C83E';
                } else {
                    init_color = '#00FF00';
                }

            }, 1000)
        },
        error: function (error) {
            console.log(error);
        }
    })
}