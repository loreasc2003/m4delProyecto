<script setup lang="ts">
import { CurrencyDollarIcon } from 'vue-tabler-icons';

</script>
<template>
  <v-card elevation="10">
    <v-card-text class="pb-sm-8">
      <div class="d-flex justify-space-between">
        <div>
          <h4 class="text-subtitle-1 font-weight-medium text-medium-emphasis pb-1">
            Earnings
          </h4>
          <h3 class="text-h4">$63,438.39</h3>
        </div>
        <v-btn color="primary" class="btn-custom-sm" icon>
          <CurrencyDollarIcon/>
        </v-btn>
      </div>
      <v-btn color="secondary" class="mt-10"> Download </v-btn>
    </v-card-text>
  </v-card>
</template>
