var line1 = new TimeSeries();
var line2 = new TimeSeries();
 
var timeoutCPU = 1000;
var timeoutMemory = 2500;
 
function fmtPercent(v) {
   if (v<10) return '&nbsp;&nbsp;'+v.toFixed(1);
   if (v<100) return '&nbsp;'+v.toFixed(1);
   return v;
}
 
$.ajaxSetup({timeout: timeoutCPU});
 
function tickCPU() {
   $.ajax("/test/cpuUsage.dws")
     .done(
       function (data) {
         var dt = new Date().getTime();
         data = data.split('/').map(function (v) { return parseFloat(v) });
         line1.append(dt, data[0]);
         $('#process').html(fmtPercent(data[0]));
         line2.append(dt, data[1]);
         $('#system').html(fmtPercent(data[1]));
         $('#connect').hide();
       }
     ).error(
       function () {
         var dt = new Date().getTime();
         line1.append(dt, null);
         line2.append(dt, null);
         $('#connect').show();
       }
     ).complete(
       function () {
         setTimeout(tickCPU, timeoutCPU - 30);
       }
     )       
 };
 tickCPU();
 
 function tickMemory() {
   $.ajax("/test/systemMemoryInfo.dws")
     .done(
       function (data) {
         $('#memory').html(data);
       }
     ).complete(
       function () {
         setTimeout(tickMemory, timeoutMemory);
       }
     )       
 };
 setTimeout(tickMemory, timeoutMemory);
 
 var smoothie = new SmoothieChart(
   { 
     grid: { 
       strokeStyle: 'rgb(125, 0, 0)', 
       fillStyle: '#400', 
       lineWidth: 1, 
       millisPerLine: 1000, 
       verticalSections: 10,
     },
     interpolation: 'line',
     millisPerPixel: 50,
     minValue: 0,
     maxValue: 100
   });
 smoothie.addTimeSeries(line1, 
                        {
                          strokeStyle: 'rgb(0, 255, 0)',
                          fillStyle: 'rgba(0, 255, 0, 0.4)', 
                          lineWidth: 2 
                        });
 smoothie.addTimeSeries(line2, 
                        { 
                          strokeStyle: 'rgb(255, 0, 255)', 
                          fillStyle: 'rgba(255, 0, 255, 0.3)', 
                          lineWidth: 2
                        });
 
 smoothie.streamTo(document.getElementById("mycanvas"), 1000);