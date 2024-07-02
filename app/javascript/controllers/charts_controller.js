import { Controller } from "@hotwired/stimulus"
import ApexCharts from 'apexcharts'

// Connects to data-controller="charts"
export default class extends Controller {
  connect() {
    console.log(this.element);

    let weightData;
    let bodyfatData;

    fetch('/statsdata')
      .then(response => response.json())
      .then(data => {
        console.table(data); // Log the data or use it as needed
        weightData = data.weight;
        bodyfatData = data.bodyfat;

      let options = {
        series: [{
          name: "Weight",
          data: weightData 
      }],
        chart: {
        height: 350,
        type: 'line',
        zoom: {
          enabled: false
        }
      },
      dataLabels: {
        enabled: false
      },
      stroke: {
        curve: 'straight'
      },
      title: {
        text: 'Weight',
        align: 'left'
      },
      grid: {
        row: {
          colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
          opacity: 0.5
        },
      },
      xaxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
      }
      };

      let options2 = {
        series: [{
          name: "Bodyfat",
          data: bodyfatData 
      }],
        chart: {
        height: 350,
        type: 'line',
        zoom: {
          enabled: false
        }
      },
      dataLabels: {
        enabled: false
      },
      stroke: {
        curve: 'straight'
      },
      title: {
        text: 'Bodyfat',
        align: 'left'
      },
      grid: {
        row: {
          colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
          opacity: 0.5
        },
      },
      xaxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
      }
      };

      let weightChartElement = document.querySelector("#weightChart");
      let weightChart = new ApexCharts(weightChartElement, options);
      weightChart.render();

      // change this to bodyfat
      let heightChartElement = document.querySelector("#heightChart");
      let heightChart = new ApexCharts(heightChartElement, options2);
      heightChart.render();

      })
      .catch(error => console.error('Error fetching stats data:', error));

  }
}
