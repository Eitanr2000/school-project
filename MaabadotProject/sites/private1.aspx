<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="private1.aspx.cs" Inherits="sites_private1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta charset="UTF-8">
    <title>נפילה חופשית - הדמיה</title>
        <link href="..\stylesheets\other.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            direction: rtl;
            padding: 20px;
            text-align: center;
        }
        canvas {
            border: 1px solid #333;
            display: block;
            margin: 20px auto;
        }
        .controls {
            margin-bottom: 20px;
        }
        label, select, button {
            font-size: 1.2em;
            margin: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="controls">
            <label for="massSelect">בחר מסה (ק"ג):</label>
            <select id="massSelect">
                <option value="0.1">0.1</option>
                <option value="0.5">0.5</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="5">5</option>
            </select>
            <button type="button" onclick="startSimulation()">הפעל ניסוי</button>
        </div>

        <canvas id="fallCanvas" width="300" height="600"></canvas>
    <%-- canvas הוא משמש כלוח שניתן לצייר עליו בעזרת JS --%>
        <div>
            <h3>גרפים</h3>
            <canvas id="positionGraph" width="400" height="200"></canvas>
            <canvas id="velocityGraph" width="400" height="200"></canvas>
        </div>


    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!--הפעולה מחברת הספרייה charjs שנותנת אפשרות לעבוד עם גרפים -->
    <script>
        let ctx = document.getElementById('fallCanvas').getContext('2d');
        let interval;
        let points = [];
        let time = 0;
        const dt = 0.02;
        const g = 9.8; // תאוצה קבועה

        function drawPoint(y) {
            ctx.beginPath();
            ctx.arc(150, y, 3, 0, Math.PI * 2);
            ctx.fillStyle = 'black';
            ctx.fill();
        }

        function startSimulation() {
            const selectedMass = parseFloat(document.getElementById('massSelect').value);
            ctx.clearRect(0, 0, 300, 600);
            points = [];
            time = 0;
            let y = 0;
            //הפונקציה מובנת ב js והיא מבצעת את הקוד כל שנייה setInterval(function, interval);
            interval = setInterval(function() {
                y = 0.5 * g * time * time * 100 / 9.8; 
                if (y > 580) {
                    clearInterval(interval);//עוצר את החזרות
                    plotGraphs();//מצייר את הגרפים
                    return;
                }
                drawPoint(y);//מצייר את הנקודה
                points.push({
                    t: time,
                    x: y / 100 * 9.8,
                    m: selectedMass
                });//מוסיף נתונים למילון במערך
                time += dt;
            }, 100);

        }

        function plotGraphs() {
            const posCtx = document.getElementById('positionGraph').getContext('2d');
            const velCtx = document.getElementById('velocityGraph').getContext('2d');

            const labels = points.map(function (p) {return p.t.toFixed(2) });//עובר על כל הנקודות במערך ומעגל את הזמנים שלהם ומוסיף אותם למערך חדש
            const positions = points.map(function (p) { return p.x.toFixed(2) });
            const velocities = points.map(function (p, i) { return i === 0 ? 0 : ((p.x - points[i - 1].x) / dt).toFixed(2)});//מעגל את המהירויות ומכניס למערך חדש i-index

            new Chart(posCtx, {//משתמשים בממשק chart כדי לצייר גרף מקום זמן
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'מיקום (מ׳)',
                        data: positions,
                        borderColor: 'blue',
                        tension: 0.1
                    }]
                },
                options: {
                    scales: {
                        x: { title: { display: true, text: 'זמן (שניות)' } },
                        y: { title: { display: true, text: 'מיקום (מ׳)' } }
                    }
                }
            });

            new Chart(velCtx, {//משתמשים בממשק chart כדי לצייר גרף מהירות זמן
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'מהירות (מ/ש)',
                        data: velocities,
                        borderColor: 'green',
                        tension: 0.1
                    }]
                },
                options: {
                    scales: {
                        x: { title: { display: true, text: 'זמן (שניות)' } },
                        y: { title: { display: true, text: 'מהירות (מ/ש)' } }
                    }
                }
            });
        }
    </script>
</asp:Content>

