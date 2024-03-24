<script setup lang="ts">
import { ref } from "vue";
import { topCardsData } from "@/_mockApis/components/dashboards/EcommerceData";
</script>

<template>
    <v-card elevation="10">
        <v-row>
            <v-col lg="3" cols="6" class="pa-0 border-right" v-for="(item, i) in topCardsData" :key="i">
                <div class="pa-9">
                    <div class="mt-3">
                        <v-btn color="inherit" icon :class="'pa-0 mr-3 text-' + item.color + ' bg-' + item.bgcolor">
                            <component :is="item.icon" stroke-width="1.5" size="24" />
                        </v-btn>
                    </div>
                    <div>
                        <h4 class="
                        text-h4
                        d-flex
                        align-center
                        mt-6
                      ">
                            {{ item.title }}
                            <span :class="item.status + ' text-caption ml-1'">
                                {{ item.price }}</span>
                        </h4>
                        <span class="
                        text-subtitle-1 font-weight-medium text-medium-emphasis
                      ">{{ item.desc }}</span>
                    </div>
                </div>
                <!-- <v-divider vertical></v-divider> -->
            </v-col>
        </v-row>
    </v-card>
</template>
