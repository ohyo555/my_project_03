<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAP"></c:set>
<%@ include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/background.css" />

<style>
    canvas {
        border: 1px solid #ddd;
        margin: 30px;
    }
</style>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendar-Style Chart Example</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>
</head>
<body>
    <canvas id="calendarChart"></canvas>

<script>
        // Chart.js code
        var ctx = document.getElementById('calendarChart').getContext('2d');
        
        // Sample date periods and corresponding values
        var datePeriods = [
            { start: '2022-03-01', end: '2022-03-05' },
            { start: '2022-03-06', end: '2022-03-10' },
            { start: '2022-03-11', end: '2022-03-15' },
        ];
        
        var values = [1, 2, 3];

        // Convert date strings to Date objects
        var dateLabels = datePeriods.map(function(period) {
            return period.start + ' to ' + period.end;
        });

        var calendarChart = new Chart(ctx, {
            type: 'horizontalBar', // Set the chart type to horizontalBar
            data: {
                labels: dateLabels,
                datasets: [{
                    label: 'Events',
                    data: values,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    x: {
                        type: 'category',
                        title: {
                            display: true,
                            text: 'Date Periods'
                        }
                    },
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Number of Events'
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
<%@ include file="../common/foot.jspf"%>