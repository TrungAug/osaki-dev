//add chart
document.addEventListener("DOMContentLoaded", function() {
   var labelsCtx=null;
   var valuesCtx=null;
    if(dataInventory!=null){
        labelsCtx = Object.keys(dataInventory);
        valuesCtx = Object.values(dataInventory);
    }
    const ctx = document.getElementById('myChartLine');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labelsCtx,
            datasets: [{
                label: '5 Sản phẩm tồn kho thấp nhất',
                data: valuesCtx,
                borderWidth: 1
            }]
        },
        options: {
            responsive:true,
        }
    });
    
    var labelsDoughnut=null;
    var valuesDoughnut=null;
    if(dataRevenueByCategory!=null){
        labelsDoughnut = Object.keys(dataRevenueByCategory);
        valuesDoughnut = Object.values(dataRevenueByCategory);
    }

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