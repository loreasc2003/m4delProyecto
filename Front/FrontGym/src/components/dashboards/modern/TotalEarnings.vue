<script setup lang="ts">
import type { CurrencyDollarIcon } from 'vue-tabler-icons';
</script>

<template>
  <v-card elevation="10">
    <v-card-text>
      <div class="d-flex align-start">
        <h2 class="text-h4 mt-1">Total Earnings</h2>
        <v-spacer></v-spacer>
        <div class="ml-auto">
          <v-btn color="primary" icon flat>
            <CurrencyDollarIcon/>
          </v-btn>
        </div>
      </div>
      <div class="mt-9">
        <h2 class=" text-h4 font-weight-semibold mb-1">$93,438.78</h2>
        <span class="text-subtitle-1 text-medium-emphasis font-weight-medium">Monthly Revenue</span>
      </div>
    </v-card-text>
  </v-card>
</template>