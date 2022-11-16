async function pred_operation() {
    const pred_date = $('#datepicker').val();
    const chk_date = new Date();
    const chk_date_limit = new Date();
    const chk_date_from = new Date(pred_date);
    chk_date_limit.setDate(chk_date.getDate() + 365);

    if (chk_date > chk_date_from) {
        alert('예측 시작날짜는 오늘, 과거가 될 수 없습니다.');
        return;
    }

    if (chk_date_from > chk_date_limit) {
        alert('최대 예측 가능 범위는 1년입니다.');
        return;
    }

    const load_pred = $('#load_pred');
    load_pred.empty();
    load_pred.append('학습모델 실행중...');
    await $.ajax({
        url: '/pred/search',
        type: 'GET',
        data: {
            date: pred_date
        },
        dataType: "json",
        timeout: 10000,
        contentType: "application/json",
        success: function (data) {
            setTimeout(() => {
                load_pred.empty();
                const title = $('#title');
                const pred_month = $('#pred_month');
                const pred_years = $('#pred_years');
                const comment01 = $('#comment01');
                const comment02 = $('#comment02');

                title.empty();
                pred_month.empty();
                pred_years.empty();
                comment01.empty();
                comment02.empty();

                title.append('<h3 class="text-black-50">' + data.that_date + ' 기준</h3>');
                pred_month.append('<h4 class="mb-0"><b style="color: #0d6efd">' + (data.month_Elm[4]).toFixed(2) + '</b> m / 약 <b style="color: #0d6efd">' + (Math.ceil(data.month_rsqty[4]) * 1000).toLocaleString() + '</b> ㎥</h4>');
                pred_years.append('<h4 class="mb-0"><b style="color: #0d6efd">' + (data.year_Elm[11]).toFixed(2) + '</b> m / 약 <b style="color: #0d6efd">' + (Math.ceil(data.year_rsqty[11]) * 1000).toLocaleString() + '</b> ㎥</h4>');
                comment01.append('<p class="mb-0"> 현재 수량 및 수위 : ' +
                    '<span class="text-success font-weight-bolder">'+ data.cal_ELm +'</span> m / <span class="text-success font-weight-bolder">'+ (Math.ceil(data.cal_rsqty) * 1000).toLocaleString() +'</span> ㎥' +
                    '</p>')
                comment02.append('<p class="mb-0"> 현재 수량 및 수위 : ' +
                    '<span class="text-success font-weight-bolder">'+ data.cal_ELm +'</span> m / <span class="text-success font-weight-bolder">'+ (Math.ceil(data.cal_rsqty) * 1000).toLocaleString() +'</span> ㎥' +
                    '</p>')

                const chart01 = $('#chart01');
                chart01.empty();
                chart01.append('<canvas id="chart-bars" class="chart-canvas" height="170"></canvas>');

                const ctx = document.getElementById("chart-bars").getContext("2d");

                new Chart(ctx, {
                    type: "line",
                    data: {
                        labels: [data.month_list[0], data.month_list[1], data.month_list[2], data.month_list[3], data.month_list[4], data.month_list[5], data.month_list[6], data.month_list[7], data.month_list[8], data.month_list[9], data.month_list[10], data.month_list[11]],
                        datasets: [{
                            label: "수위 ",
                            tension: 0,
                            borderWidth: 0,
                            pointRadius: 5,
                            pointBackgroundColor: "rgba(255, 255, 255, .8)",
                            pointBorderColor: "transparent",
                            borderColor: "rgba(255, 255, 255, .8)",
                            borderColor: "rgba(255, 255, 255, .8)",
                            borderWidth: 4,
                            backgroundColor: "transparent",
                            fill: true,
                            data: [data.year_Elm[0], data.year_Elm[1], data.year_Elm[2], data.year_Elm[3], data.year_Elm[4], data.year_Elm[5], data.year_Elm[6], data.year_Elm[7], data.year_Elm[8], data.year_Elm[9], data.year_Elm[10], data.year_Elm[11]],
                            maxBarThickness: 6
                        },],
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        color: 'rgba(255, 255, 255, .2)',
                        plugins: {
                            legend: {
                                display: false,
                            }
                        },
                        interaction: {
                            intersect: false,
                            mode: 'index',
                        },
                        scales: {
                            y: {
                                grid: {
                                    drawBorder: false,
                                    display: true,
                                    drawOnChartArea: true,
                                    drawTicks: false,
                                    borderDash: [3, 5],
                                    color: 'rgba(255, 255, 255, .2)'
                                },
                                ticks: {
                                    suggestedMin: 100,
                                    suggestedMax: 105,
                                    beginAtZero: false,
                                    padding: 10,
                                    font: {
                                        size: 14,
                                        weight: 300,
                                        family: "Roboto",
                                        style: 'normal',
                                        lineHeight: 2
                                    },
                                    color: "#fff"
                                },
                            },
                            x: {
                                grid: {
                                    drawBorder: false,
                                    display: true,
                                    drawOnChartArea: true,
                                    drawTicks: false,
                                    borderDash: [5, 5],
                                    borderWidth: 10,
                                    color: 'rgba(255, 255, 255, .2)'
                                },
                                ticks: {
                                    display: true,
                                    color: '#f8f9fa',
                                    padding: 10,
                                    font: {
                                        size: 14,
                                        weight: 300,
                                        family: "Roboto",
                                        style: 'normal',
                                        lineHeight: 2
                                    },
                                }
                            },
                        },
                    },
                });

                const card01 = $('#card01');
                card01.empty();
                card01.append('<h6 class="text-lg mb-0 GOTHIC_M">' + data.that_date + ' 기준 1년 후 <b style="color: #4caf50">수위 예측 결과</b></h6>' +
                    '<p class="text-sm GOTHIC_M text-black-50">(최저지점 기준)</p>' +
                    '<hr class="dark horizontal">' +
                    '<div class="d-flex ">' +
                    '<i class="material-icons text-sm my-auto me-1">schedule</i>' +
                    '<p class="mb-0 text-sm">예측오차 : ±5%</p>' +
                    '</div>');

                const chart02 = $('#chart02');
                chart02.empty();
                chart02.append('<canvas id="chart-line" class="chart-canvas" height="170"></canvas>');

                const ctx2 = document.getElementById("chart-line").getContext("2d");

                new Chart(ctx2, {
                    type: "line",
                    data: {
                        labels: [data.month_list[0], data.month_list[1], data.month_list[2], data.month_list[3], data.month_list[4], data.month_list[5], data.month_list[6], data.month_list[7], data.month_list[8], data.month_list[9], data.month_list[10], data.month_list[11]],
                        datasets: [{
                            label: "수량(천 ㎥) ",
                            tension: 0,
                            borderWidth: 0,
                            pointRadius: 5,
                            pointBackgroundColor: "rgba(255, 255, 255, .8)",
                            pointBorderColor: "transparent",
                            borderColor: "rgba(255, 255, 255, .8)",
                            borderColor: "rgba(255, 255, 255, .8)",
                            borderWidth: 4,
                            backgroundColor: "transparent",
                            fill: true,
                            data: [data.year_rsqty[0], data.year_rsqty[1], data.year_rsqty[2], data.year_rsqty[3], data.year_rsqty[4], data.year_rsqty[5], data.year_rsqty[6], data.year_rsqty[7], data.year_rsqty[8], data.year_rsqty[9], data.year_rsqty[10], data.year_rsqty[11]],
                            maxBarThickness: 6

                        }],
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        color: 'rgba(255, 255, 255, .2)',
                        plugins: {
                            legend: {
                                display: false,
                            }
                        },
                        interaction: {
                            intersect: false,
                            mode: 'index',
                        },
                        scales: {
                            y: {
                                grid: {
                                    drawBorder: false,
                                    display: true,
                                    drawOnChartArea: true,
                                    drawTicks: false,
                                    borderDash: [5, 5],
                                    color: 'rgba(255, 255, 255, .2)'
                                },
                                ticks: {
                                    display: true,
                                    color: '#f8f9fa',
                                    padding: 10,
                                    font: {
                                        size: 14,
                                        weight: 300,
                                        family: "Roboto",
                                        style: 'normal',
                                        lineHeight: 2
                                    },
                                }
                            },
                            x: {
                                grid: {
                                    drawBorder: false,
                                    display: true,
                                    drawOnChartArea: true,
                                    drawTicks: false,
                                    borderDash: [5, 5],
                                    color: 'rgba(255, 255, 255, .2)'
                                },
                                ticks: {
                                    display: true,
                                    color: '#f8f9fa',
                                    padding: 10,
                                    font: {
                                        size: 14,
                                        weight: 300,
                                        family: "Roboto",
                                        style: 'normal',
                                        lineHeight: 2
                                    },
                                }
                            },
                        },
                    },
                });

                const card02 = $('#card02');
                card02.empty();
                card02.append('<h6 class="text-lg mb-0 GOTHIC_M">' + data.that_date + ' 기준 1년 후 <b style="color: #4caf50">수량 예측 결과</b></h6>' +
                    '<p class="text-sm GOTHIC_M text-black-50">(자정 기준)</p>' +
                    '<hr class="dark horizontal">' +
                    '<div class="d-flex ">' +
                    '<i class="material-icons text-sm my-auto me-1">schedule</i>' +
                    '<p class="mb-0 text-sm">예측오차 : ±5%</p>' +
                    '</div>');

                // 데이터 그리기
                const contents = $('#contents');
                contents.empty();
                for (let i = 0; i < 5; i++) {
                    let cal_date = data.date_list[i];
                    contents.append('<tr>' +
                        '<td>' + data.date_list[i] + '</td>' +
                        '<td>' + (data.month_Elm[i]).toFixed(2) + '</td>' +
                        '<td>' + Math.ceil(data.month_rsqty[i]) + '</td>' +
                        '</tr>');
                }
            }, 1000)
        },
        error: function (error) {
            console.log(error);
        }
    })
}