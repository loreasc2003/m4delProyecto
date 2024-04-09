<script setup lang="ts">
import { ref, computed } from "vue";
import { getPrimary, getSecondary } from '@/utils/UpdateColors';
/*Chart */
const Chart = computed(() => {
    return {
        series: [
            {
                name: "Customers",
                data: [1, 19, 3, 13, 2, 19],
            },
        ],

        chart: {
            toolbar: {
                show: false,
            },
            foreColor: "#adb0bb",
            fontFamily: `inherit`,
            type: "line",
            height: 55,
            sparkline: {
                enabled: true,
            },
        },
        colors: ["rgb(255,255,255)"],

        marker: {
            size: 0,
        },

        tooltip: {
            theme: "dark",
        },

        grid: {
            show: false,
        },

        stroke: {
            show: true,
            width: 2,
            curve: "smooth",
        },
    }
});
</script>

<template>
    <v-card elevation="10" class="position-relative bg-primary">
        <v-card-text  class="pb-sm-7">
            <h2 class="text-h4">Customers</h2>
            <div class="mt-4">
                <apexchart type="line" height="55px" :options="Chart" :series="Chart.series"></apexchart>
            </div>
            <h2 class=" text-h4 pt-8  d-flex align-items-end">
                $39,358
                <span class="text-subtitle-1 ml-2 d-flex align-center font-weight-medium "><ArrowUpLeftIcon  size="18"/>+9 this week</span>
            </h2>
        </v-card-text>
    </v-card>
</template>
