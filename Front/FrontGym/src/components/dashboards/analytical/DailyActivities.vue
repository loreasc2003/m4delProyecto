<script setup lang="ts">
import { ref } from "vue";
import {dailyActivitiesData} from "@/_mockApis/components/dashboards/AnalyticalData"
const items = ref([
    { title: "Click Me" },
    { title: "Click Me" },
    { title: "Click Me" },
    { title: "Click Me 2" },
]);
</script>
<template>
    <v-card elevation="10">
        <v-card-text class="pb-sm-13 ">
            <div class="d-flex align-center mb-1">
                <h2 class="text-h4">Daily Activities</h2>
                <v-spacer></v-spacer>
                <div class="ml-auto text-no-wrap">
                    <v-menu bottom left>
                        <template v-slot:activator="{ props }">
                            <v-btn icon color="inherit" v-bind="props" flat>
                                <DotsIcon stroke-width="1.5" size="20" />
                            </v-btn>
                        </template>
                        <v-list>
                            <v-list-item v-for="(item, i) in items" :key="i">
                                <v-list-item-title>{{ item.title }}</v-list-item-title>
                            </v-list-item>
                        </v-list>
                    </v-menu>
                </div>
            </div>
            <v-timeline  class="theme-timeline pt-3" density="compact" side="end" truncate-line="both">
                <v-timeline-item v-for="item in dailyActivitiesData"  :key="item.title" class="mb-4" :dot-color="item.color" fill-dot size="x-small">
                    <div class="d-flex justify-space-between">
                        <div class="h5 font-weight-medium">{{ item.title }}</div>
                        <span class="text-medium-emphasis text-subtitle-1 font-weight-medium ml-auto text-no-wrap">{{ item.time }}</span>
                    </div>
                </v-timeline-item>
            </v-timeline>
        </v-card-text>
    </v-card>
</template>
