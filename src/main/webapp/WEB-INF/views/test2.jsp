<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <%@include file="include/link_js.jsp" %>
            <style>


            </style>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
            <script src="https://code.highcharts.com/highcharts.js"></script>
            <script src="https://code.highcharts.com/modules/data.js"></script>
            <script src="https://code.highcharts.com/modules/drilldown.js"></script>
            <script src="https://code.highcharts.com/modules/exporting.js"></script>
            <script src="https://code.highcharts.com/modules/export-data.js"></script>
            <script src="https://code.highcharts.com/modules/accessibility.js"></script>
            <script src="https://code.highcharts.com/modules/series-label.js"></script>
    </head>

    <body>
        <div id="container"></div>
        <p class="highcharts-description">
            Chart showing data loaded dynamically. The individual data points can
            be clicked to display more information.
        </p>

        <script>
            Highcharts.addEvent(Highcharts.Point, 'click', function () {
                if (this.series.options.className.indexOf('popup-on-click') !== -1) {
                    const chart = this.series.chart;
                    const text = "<b>게시글 수: " + this.y + "</b><br/>" + this.name;

                    const anchorX = this.plotX + this.series.xAxis.pos;
                    const anchorY = this.plotY + this.series.yAxis.pos;
                    const align = anchorX < chart.chartWidth - 200 ? 'left' : 'right';
                    const x = align === 'left' ? anchorX + 10 : anchorX - 10;
                    const y = anchorY - 30;

                    if (!chart.sticky) {
                        chart.sticky = chart.renderer
                            .label(text, x, y, 'callout', anchorX, anchorY)
                            .attr({
                                align,
                                fill: 'rgba(0, 0, 0, 0.75)',
                                padding: 10,
                                zIndex: 7 // Above series, below tooltip
                            })
                            .css({
                                color: 'white'
                            })
                            .on('click', function () {
                                this.destroy();
                            })
                            .add();
                    } else {
                        chart.sticky
                            .attr({ align, text })
                            .animate({ anchorX, anchorY, x, y }, { duration: 250 });
                    }
                }
            });

            Highcharts.chart('container', {
                chart: {
                    scrollablePlotArea: {
                        minWidth: 700
                    }
                },
                data: {
                    csvURL: 'https://www.highcharts.com/samples/data/analytics.csv',
                    beforeParse: function (csv) {
                        return csv.replace(/\n\n/g, '\n');
                    }
                },
                title: {
                    text: 'Daily sessions at www.highcharts.com',
                    align: 'left'
                },
                subtitle: {
                    text: 'Source: Google Analytics',
                    align: 'left'
                },
                xAxis: {
                    tickInterval: 7 * 24 * 3600 * 1000, // one week
                    tickWidth: 0,
                    gridLineWidth: 1,
                    labels: {
                        align: 'left',
                        x: 3,
                        y: -3
                    }
                },
                yAxis: [{ // left y axis
                    title: {
                        text: null
                    },
                    labels: {
                        align: 'left',
                        x: 3,
                        y: 16,
                        format: '{value:.,0f}'
                    },
                    showFirstLabel: false
                }, { // right y axis
                    linkedTo: 0,
                    gridLineWidth: 0,
                    opposite: true,
                    title: {
                        text: null
                    },
                    labels: {
                        align: 'right',
                        x: -3,
                        y: 16,
                        format: '{value:.,0f}'
                    },
                    showFirstLabel: false
                }],
                legend: {
                    align: 'left',
                    verticalAlign: 'top',
                    borderWidth: 0
                },
                tooltip: {
                    shared: true,
                    crosshairs: true
                },
                plotOptions: {
                    series: {
                        cursor: 'pointer',
                        className: 'popup-on-click',
                        marker: {
                            lineWidth: 1
                        }
                    }
                },
                series: [{
                    name: 'All sessions',
                    lineWidth: 4,
                    marker: {
                        radius: 4
                    }
                }, {
                    name: 'New users'
                }]
            });

            

        </script>

    </body>


    </html>