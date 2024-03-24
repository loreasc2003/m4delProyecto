<script setup lang="ts">
import { ref, onMounted, computed } from "vue";
import { getPrimary, getSecondary } from '@/utils/UpdateColors';
/*Chart*/
const chartOptions = computed(() => {
  return {
    series: [
      { name: "Ample", data: [355, 390, 300, 350, 390, 180] },
      { name: "Pixel", data: [280, 250, 325, 215, 250, 310] },
    ],
    grid: {
      show: false,
      borderColor: "transparent",
      padding: { left:10, right: 0, bottom: 0 },
    },
    plotOptions: {
      bar: { horizontal: false, columnWidth: "42%", borderRadius: 5 },
    },
    colors: [getPrimary.value, getSecondary.value],
    fill: { type: "solid", opacity: 1 },
    chart: {
      type: "bar",
      height: 270,
      offsetX: -15,
      toolbar: { show: false },
      foreColor: "#adb0bb",
      fontFamily: `inherit`,
      sparkline: { enabled: false },
      
    },
    dataLabels: { enabled: false },
    markers: { size: 0 },
    legend: { show: false },
    xaxis: {
      type: "category",
      categories: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
      labels: {
        style: { cssClass: "grey--text lighten-2--text fill-color" },
      },
      axisBorder: {
        show: false,
      },
    },
    yaxis: {
      show: true,
      min: 100,
      max: 400,
      tickAmount: 3,
      labels: {
        style: {
          cssClass: "grey--text lighten-2--text fill-color",
        },
      },
      
    },
    stroke: {
      show: true,
      width: 5,
      lineCap: "butt",
      colors: ["transparent"],
    },
    tooltip: { theme: "dark" },
  }
});

</script>

<template>
  <!-- ------------------------------------ -->
  <!-- html -->
  <!-- ------------------------------------ -->
  <v-card elevation="10" class="pb-0">
    <v-card-text >
      <div class="d-sm-flex align-center">
        <div>
          <h3 class="text-h4">Sales Overview</h3>
        </div>
        <v-spacer></v-spacer>
        <div class="ml-auto">
          <div class="d-flex align-center">
            <div class="d-flex align-center px-2">
              <span class="text-primary">
                <span class="text-overline">
                  <i class="mdi mdi-brightness-1 mx-1"></i>
                </span>
                <span class="text-subtitle-1">Ample</span>
              </span>
            </div>
            <div class="d-flex align-center px-2">
              <span class="text-secondary">
                <span class="text-overline">
                  <i class="mdi mdi-brightness-1 mx-1"></i>
                </span>
                <span class="text-subtitle-1">Pixel Admin</span>
              </span>
            </div>
          </div>
        </div>
      </div>
      <div>
        <apexchart type="bar" height="270px" :options="chartOptions" :series="chartOptions.series">
        </apexchart>
      </div>
    </v-card-text>
  </v-card>
</template>
