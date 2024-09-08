<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Analytics - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-gray-100">

<section class="py-16">
    <div class="container mx-auto max-w-4xl bg-white p-8 rounded-lg shadow-lg">
        <h2 class="text-3xl font-bold mb-6 text-primary">Sales Analytics</h2>

        <div id="errorMessage" class="mb-4 bg-red-100 text-red-700 p-4 rounded-lg hidden">
            Failed to fetch sales analytics. Please try again.
        </div>

        <div class="mb-4">
            <canvas id="salesChart"></canvas>
        </div>
    </div>
</section>

<script>
    $(document).ready(function() {
        function fetchSalesData() {
            $.ajax({
                url: '/controller/sales-analytics',
                method: 'GET',
                dataType: 'json',
                success: function(data) {
                    updateChart(data);
                },
                error: function() {
                    $('#errorMessage').removeClass('hidden');
                }
            });
        }

        function updateChart(salesData) {
            const ctx = document.getElementById('salesChart').getContext('2d');
            const labels = Object.keys(salesData);
            const data = Object.values(salesData);

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Products Sold',
                        data: data,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // Fetch and display sales data on page load
        fetchSalesData();
    });
</script>

</body>
</html>
