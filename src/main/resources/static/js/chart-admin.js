//add chart
document.addEventListener("DOMContentLoaded", function() {
    var labelsCtx = Object.keys(dataInventory);
    var valuesCtx = Object.values(dataInventory);

    const ctx = document.getElementById('myChartLine');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labelsCtx,
            datasets: [{
                label: 'Sản phẩm tồn kho',
                data: valuesCtx,
                borderWidth: 1
            }]
        },
        options: {
            responsive:true,
        }
    });
    
    
    var labelsDoughnut = Object.keys(dataRevenueByCategory);
    var valuesDoughnut = Object.values(dataRevenueByCategory);
    const doughnut = document.getElementById('myChartDoughnut');

    new Chart(doughnut, {
        type: 'doughnut',
        data: {
            labels: labelsDoughnut,
            datasets: [{
                label: 'Doanh thu',
                data: valuesDoughnut,
                borderWidth: 1
                }]
            },
        options: {
            responsive:true,
        }
    });
    
    
    
    
});
