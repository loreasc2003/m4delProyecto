<script setup lang="ts">
import { ref } from "vue";
import BaseBreadcrumb from "@/components/shared/BaseBreadcrumb.vue";
import CongratulationCard from "@/components/dashboards/modern/CongratulationCard.vue";
import Purchases from "@/components/dashboards/modern/Purchases.vue";
import TotalEarnings from "@/components/dashboards/modern/TotalEarnings.vue";
import RevenueUpdates from "@/components/dashboards/modern/RevenueUpdates.vue";
import MonthlyEarnings from "@/components/dashboards/modern/MonthlyEarnings.vue";
import Customers from "@/components/dashboards/modern/Customers.vue";
import TotalSales from "@/components/dashboards/analytical/TotalSales.vue";
import ProductPerformance from "@/components/dashboards/modern/ProductPerformance.vue";
import DailyActivities from "@/components/dashboards/analytical/DailyActivities.vue";
import TheSalesOverview from "@/components/dashboards/analytical/TheSalesOverview.vue";
import TheBlogCard from "@/components/dashboards/analytical/TheBlogCard.vue";
import WeeklyStats from "@/components/dashboards/analytical/WeeklyStats.vue";
import MedicalProBranding from "@/components/dashboards/ecommerce/MedicalProBranding.vue";


const page = ref({ title: "Modern" });
const breadcrumbs = ref([
    {
        text: "Dashboard",
        disabled: false,
        href: "#",
    },
    {
        text: "Modern",
        disabled: true,
        href: "#",
    },
]);
</script>

<template>
    <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb>
    <v-row>
        <!---Congratulation card---->
        <v-col cols="12" sm="12" lg="5">
            <CongratulationCard />
        </v-col>
        <!---Purchase / Total earnings---->
        <v-col cols="12" sm="12" lg="7">
            <v-row>
                <v-col lg="5">
                    <Purchases />
                </v-col>
                <v-col lg="7">
                    <TotalEarnings />
                </v-col>
            </v-row>
        </v-col>
        <!---Revenue updates---->
        <v-col cols="12" sm="12" lg="8">
            <RevenueUpdates />
        </v-col>
        <!---Monthly earnings / Customers---->
        <v-col cols="12" sm="12" lg="4">
            <MonthlyEarnings />
            <Customers />
        </v-col>
        <!---Total sales---->
        <v-col cols="12" sm="12" lg="4">
            <TotalSales />
        </v-col>
        <!---Product performence---->
        <v-col cols="12" sm="12" lg="8">
            <ProductPerformance />
        </v-col>
        <v-col cols="12" sm="12" lg="5">
            <DailyActivities />
        </v-col>
        <v-col cols="12" sm="12" lg="7" class="d-flex align-stretch">
            <TheSalesOverview />
        </v-col>
        <!---Blog card---->
        <v-col cols="12" lg="4">
            <TheBlogCard />
        </v-col>
        <!---Weekly stats---->
        <v-col cols="12" lg="4">
            <WeeklyStats />
        </v-col>
        <!---Mediacal pro branding---->
        <v-col cols="12" lg="4">
            <MedicalProBranding />
        </v-col>
    </v-row>
</template>
