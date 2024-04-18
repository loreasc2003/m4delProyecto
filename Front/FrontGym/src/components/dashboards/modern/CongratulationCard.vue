<script setup lang="ts">
import type { ArrowUpLeftIcon } from 'vue-tabler-icons';

</script>
<template>
  <v-card elevation="10" class="position-relative overflow-hidden">
    <img src="@/assets/images/backgrounds/welcome-bg2-2x-svg.svg" class="bg-img-1" />
    <v-card-text>
      <h2 class=" text-h4 overlay-title ">
        Congratulation Julia
      </h2>
      <h2 class="text-h4 font-weight-semibold mt-4 d-flex align-end mb-1">
        $39,358
        <span class="text-subtitle-1  ml-2 d-flex align-center textSecondary font-weight-medium">
          <ArrowUpLeftIcon size="18" />+9%
        </span>
      </h2>
      <v-btn color="primary" class="mt-7" flat> Download </v-btn>
    </v-card-text>
  </v-card>
</template>

<style scoped>
.overlay-title {
  position: relative;
  z-index: 1;
}
.bg-img-1 {
  position: absolute;
  right: -19%;
  width: 340px;
  top:0;
}
</style>
