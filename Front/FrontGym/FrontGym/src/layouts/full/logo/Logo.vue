<script setup>
import { computed } from "vue";
import LogoLight from "./LogoLight.vue";
import LogoDark from "./LogoDark.vue";
import RtlLogoDark from "./RtlLogoDark.vue";
import RtlLogoLight from "./RtlLogoLight.vue";
import { useCustomizerStore } from "@/stores/customizer";

const customizer = useCustomizerStore();

//const dark = ref(false);
const dark = computed(() => {
  if (
    customizer.actTheme === "DARK_BLUE_THEME" ||
    customizer.actTheme === "DARK_RED_THEME" ||
    customizer.actTheme === "DARK_ORANGE_THEME" ||
    customizer.actTheme === "DARK_PURPLE_THEME" ||
    customizer.actTheme === "DARK_GREEN_THEME" ||
    customizer.actTheme === "DARK_INDIGO_THEME"
  ) {
    return true;
  } else {
    return false;
  }
});
</script>
<template>
  <v-locale-provider v-if="customizer.setRTLLayout" rtl>
    <RtlLogoLight v-if="dark" />
    <RtlLogoDark v-else />
  </v-locale-provider>
  <v-locale-provider v-else>
    <LogoLight v-if="dark" />
    <LogoDark v-else />
  </v-locale-provider>
</template>
