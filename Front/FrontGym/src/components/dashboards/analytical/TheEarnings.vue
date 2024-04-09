
import { CurrencyDollarIcon } from 'vue-tabler-icons';


<template>
    <v-card elevation="10" class="bg-primary">
        <v-card-text>
            <div class="d-flex align-start">
                <h2 class="text-h4">Earnings</h2>
                <v-spacer></v-spacer>
                <div class="ml-auto">
                    <v-btn depressed color="white" class="btn-custom-sm" small icon>
                        <CurrencyDollarIcon  class="textSecondary"/>
                    </v-btn>
                </div>
            </div>
            <div class="mt-4">
                <h2 class="text-h4 font-weight-regular">$93,438.78</h2>
                <span class="text-subtitle-1">Monthly revenue</span>
            </div>
        </v-card-text>
    </v-card>
</template>
