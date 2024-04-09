<script setup lang="ts">
import { ref } from 'vue';
import completed from '@/assets/images/products/payment-complete.svg';
</script>

<template>
    <v-card>
        <v-card-item class="py-8 text-center">
            <h3 class="text-h3">¡Gracias por el pedido!</h3>
            <p class="text-medium-emphasis mt-3 mb-2">Le enviaremos una notificación del proceso antes de su entrega.</p>
            <p>Su id de pedido: <span class="text-primary">97e3-bd65d98b1559</span></p>
            <div class="text-center">
            <img :src="completed" alt="Thankyou" class="my-6" width="250" />
            </div>
            <small class="text-medium-emphasis"
                >Si tiene alguna consulta o pregunta sobre la compra de artículos, no dude en ponerse en contacto con nosotros.</small
            ><br />
            <span class="text-error">(776) 124-9571</span>
            <div class="d-sm-flex align-center justify-center gap-3 mt-5 mb-5">
                <v-btn color="primary" variant="tonal" to="/ecommerce/products">Continuar comprando</v-btn>
                <v-btn color="primary" class="mt-4 mt-sm-0">Descargar factura</v-btn>
            </div>
        </v-card-item>
    </v-card>
</template>
