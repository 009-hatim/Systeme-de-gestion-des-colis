<%@page import="dao.ColisDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chart Test Page</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .chart-container {
            width: 80%;
            height: 400px;
            margin: 30px auto;
            border: 1px solid #ddd;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .data-info {
            background: #f5f5f5;
            padding: 15px;
            margin: 20px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h1 style="text-align: center;">Test Chart with Database Data</h1>
    
    <%
    // Get data directly from database
    ColisDao colisDao = new ColisDao();
    int enAttente = colisDao.findByStatut("En attente").size();
    int enTransit = colisDao.findByStatut("En transit").size();
    int livre = colisDao.findByStatut("Livré").size();
    int total = enAttente + enTransit + livre;
    %>
    
    <div class="data-info">
        <h3>Data from Database:</h3>
        <p>En attente: <%= enAttente %></p>
        <p>En transit: <%= enTransit %></p>
        <p>Livré: <%= livre %></p>
        <p>Total: <%= total %></p>
    </div>
    
    <div class="chart-container">
        <canvas id="statusChart"></canvas>
    </div>

    <script>
    // Create chart with data from JSP variables
    document.addEventListener('DOMContentLoaded', function() {
        const ctx = document.getElementById('statusChart').getContext('2d');
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: ['En attente', 'En transit', 'Livré'],
                datasets: [{
                    data: [<%= enAttente %>, <%= enTransit %>, <%= livre %>],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.7)',
                        'rgba(54, 162, 235, 0.7)',
                        'rgba(75, 192, 192, 0.7)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    title: {
                        display: true,
                        text: 'Statut des colis (Direct from Database)'
                    },
                    legend: {
                        position: 'right',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.raw || 0;
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = Math.round((value / total) * 100);
                                return `${label}: ${value} (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        });
    });
    </script>
    
    <div style="margin: 20px; padding: 15px; background: #eef; border-radius: 5px;">
        <h3>Debug Information:</h3>
        <p>If you don't see the chart or data:</p>
        <ol>
            <li>Check your server logs for database errors</li>
            <li>Verify ColisDao.findByStatut() returns correct counts</li>
            <li>Make sure you have data in your database</li>
            <li>Check browser console (F12) for JavaScript errors</li>
        </ol>
    </div>
</body>
</html>