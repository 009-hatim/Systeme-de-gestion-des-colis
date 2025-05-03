<%@page import="dao.ColisDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Colis par Statut - Bar Chart</title>
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
    <h1 style="text-align: center;">Statistiques des colis par statut</h1>
    
    <%
        ColisDao colisDao = new ColisDao();
        int enAttente = colisDao.findByStatut("En attente").size();
        int enTransit = colisDao.findByStatut("En transit").size();
        int livre = colisDao.findByStatut("Livré").size();
        int total = enAttente + enTransit + livre;
    %>
    
    <div class="data-info">
        <h3>Données :</h3>
        <p>En attente: <%= enAttente %></p>
        <p>En transit: <%= enTransit %></p>
        <p>Livré: <%= livre %></p>
        <p>Total: <%= total %></p>
    </div>
    
    <div class="chart-container">
        <canvas id="statusBarChart"></canvas>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const ctx = document.getElementById('statusBarChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['En attente', 'En transit', 'Livré'],
                    datasets: [{
                        label: 'Nombre de colis',
                        data: [<%= enAttente %>, <%= enTransit %>, <%= livre %>],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(75, 192, 192, 0.7)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(75, 192, 192, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Nombre de colis'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Statut'
                            }
                        }
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: 'Colis par statut (Bar Chart)'
                        },
                        legend: {
                            display: false
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
