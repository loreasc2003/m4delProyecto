<script setup lang="ts">
import { ref, computed } from "vue";
import { getPrimary, getSecondary } from '@/utils/UpdateColors';
import { BasketIcon, ShoppingCartIcon } from "vue-tabler-icons";
/*Chart*/
const chartOptions = computed(() => {
    return {
        series: [
            {
                name: "Monthly Sales",
                data: [35, 60, 30, 55, 40],
            },
        ],

        colors: [getSecondary.value],
        fill: {
            colors: getSecondary.value,
            opacity: 0.05,
            type: "solid",
        },
        chart: {
            type: "area",
            height: 75,
            toolbar: {
                show: false,
            },
            foreColor: "#adb0bb",
            fontFamily: `inherit`,
            sparkline: {
                enabled: true,
            },
        },
        dataLabels: {
            enabled: false,
        },
        markers: {
            size: 0,
        },
        legend: {
            show: false,
        },
        stroke: {
            show: true,
            width: 2,
            curve: "smooth",
        },
        tooltip: {
            theme: "dark",
        },
    }
});
</script>
<template>
    <!-- ------------------------------------ -->
    <!-- html -->
    <!-- ------------------------------------ -->
    <v-card elevation="10" class="overflow-hidden w-100">
        <v-card-text class="pb-3">
            <div class="d-flex align-start">
                <div>
                    <span class="text-subtitle-1 font-weight-medium text-medium-emphasis">Monthly revenue</span>
                    <h2 class="font-weight-medium">3246</h2>
                </div>
                <v-spacer></v-spacer>
                <div class="ml-auto">
                    <v-btn icon class="btn-custom-sm" color="secondary" fab small>
                        <BasketIcon/>
                    </v-btn>
                </div>
            </div>
        </v-card-text>
        <div>
            <apexchart type="area" height="75px" :options="chartOptions" :series="chartOptions.series"></apexchart>
        </div>
    </v-card>
</template>