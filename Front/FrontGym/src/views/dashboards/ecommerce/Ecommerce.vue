<script setup lang="ts">
import { ref } from "vue";
import BaseBreadcrumb from "@/components/shared/BaseBreadcrumb.vue";
import EarningsDownload from "@/components/dashboards/ecommerce/EarningsDownload.vue";
import TopCards from "@/components/dashboards/ecommerce/TopCards.vue";
import ProductsChart from "@/components/dashboards/ecommerce/ProductsChart.vue";
import Earnings from "@/components/dashboards/ecommerce/Earnings.vue";
import YearlySales from "@/components/dashboards/ecommerce/YearlySales.vue";
import RecentTransactions from "@/components/dashboards/ecommerce/RecentTransactions.vue";
import ProductPerformance from "@/components/dashboards/ecommerce/ProductPerformance.vue";
import WeeklyStats from "@/components/dashboards/analytical/WeeklyStats.vue";
import MedicalProBranding from "@/components/dashboards/ecommerce/MedicalProBranding.vue";
import DailyActivities from "@/components/dashboards/ecommerce/DailyActivities.vue";

const page = ref({ title: "Ecommerce" });
const breadcrumbs = ref([
    {
        text: "Dashboard",
        disabled: false,
        href: "#",
    },
    {
        text: "Ecommerce",
        disabled: true,
        href: "#",
    },
]);
</script>

<template>
    <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb>
    <v-row>
        <!---Earning download--->
        <v-col cols="12" lg="4">
            <EarningsDownload />
        </v-col>
         <!---Top cards--->
        <v-col cols="12" lg="8">
            <TopCards />
        </v-col>
         <!---Product chart-->
         <v-col cols="12" lg="8">
            <ProductsChart />
        </v-col>
         <!---Earning / Yearlysales-->
        <v-col cols="12" lg="4">
            <Earnings />
            <YearlySales />
        </v-col>
        <!---Recent transaction-->
        <v-col cols="12" lg="4" class="d-flex align-items-stretch">
            <RecentTransactions />
        </v-col>
        <!---Product performence-->
        <v-col cols="12" lg="8" class="d-flex align-items-stretch">
            <ProductPerformance />
        </v-col>
        <!---WeeklyStats-->
        <v-col cols="12" lg="4">
            <WeeklyStats />
        </v-col>
        <!---Medical Pro binding-->
         <v-col cols="12" lg="4">
            <MedicalProBranding />
        </v-col>
        <!---DailyActivities-->
        <v-col cols="12" lg="4">
            <DailyActivities />
        </v-col>
    </v-row>
</template>
