<html>
<head>
    <title>Admin Dashboard - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body class="bg-gray-100 vsc-initialized">
<div class="flex w-full">
    <!-- Sidebar -->
    <%@include file="admin-sidebar.jsp" %>
    <!-- Main Content -->
    <div class="ml-64 p-8 w-full">
        <div class="flex justify-between items-center mb-1">
            <h5 class="text-xl font-bold text-gray-900 p-4">Sales Data</h5>
            <a href="/admin/dashboard" class="text-blue-600 hover:text-blue-800">Back</a>
        </div>
        <section class="py-16">
            <div class="container mx-auto max-w-4xl bg-white p-8 rounded-lg shadow-lg">
                <div id="errorMessage" class="mb-4 bg-red-100 text-red-700 p-4 rounded-lg hidden">
                    Failed to fetch sales analytics. Please try again.
                </div>

                <div class="mb-4">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </section>
    </div>
</div>
<script>
    $(document).ready(function () {
        function fetchSalesData() {
            $.ajax({
                url: '/controller/sales-analytics',
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    updateChart(data);
                },
                error: function () {
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