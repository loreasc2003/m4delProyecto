<script setup lang="ts"></script>
<template>
  <v-card elevation="10" >
    <img
      src="@/assets/images/backgrounds/welcome-bg2-2x-svg.svg"
      class="bg-img-1"
    />
    <v-card-text class="position-relative">
      <h3 class="text-h4 text-24">
        Hey John, <br />Download latest report
      </h3>
      <v-btn color="secondary" class="mt-4 mb-2"> Download </v-btn>
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
    width: 377px;
    top: 0;
}
</style>
