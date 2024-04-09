<script setup lang="ts">
import { ref } from "vue";
import { projectTableData } from "@/_mockApis/components/dashboards/AnalyticalData";
const select = ref("March");
const items = ref(["March", "April", "May", "June"]);
</script>
<template>
    <VCard elevation="10">
        <v-card-text>
            <div class="d-sm-flex align-center">
                <div>
                    <h2 class="text-h4">Product Performance</h2>
                </div>
                <v-spacer></v-spacer>
                <div class="ml-auto">
                    <v-select v-model="select" :items="items" variant="outlined" dense hide-details></v-select>
                </div>
            </div>
            <v-table class="month-table mt-5 mb-0">
                <template v-slot:default>
                    <thead>
                        <tr>
                            <th class="text-subtitle-1 font-weight-medium">Assigned</th>
                            <th class="text-subtitle-1 font-weight-medium">Name</th>
                            <th class="text-subtitle-1 font-weight-medium">Priority</th>
                            <th class="text-subtitle-1 font-weight-medium">Budget</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="item in projectTableData" :key="item.leadname" :class="item.activestate"
                            class="month-item">
                            <td>
                                <div class="d-flex align-center">
                                    <v-avatar size="40">
                                        <img :src="item.img" alt="user" width="45" />
                                    </v-avatar>
                                    <div class="mx-4">
                                        <h4 class="text-h6 text-no-wrap">
                                            {{ item.leadname }}
                                        </h4>
                                        <h6 class="text-subtitle-1 text-medium-emphasis text-no-wrap font-weight-medium mt-1">
                                            {{ item.leademail }}
                                        </h6>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <h5 class="text-subtitle-1 text-medium-emphasis text-no-wrap font-weight-medium ">
                                    {{ item.projectname }}
                                </h5>
                            </td>
                            <td>
                                <v-chip class="ma-2" :color="item.statuscolor" size="small" label>{{ item.statustext
                                }}</v-chip>
                            </td>
                            <td>
                                <h4 class="text-body-1 font-weight-semibold">{{ item.money }}</h4>
                            </td>
                        </tr>
                    </tbody>
                </template>
            </v-table>
        </v-card-text>
    </VCard>
</template>