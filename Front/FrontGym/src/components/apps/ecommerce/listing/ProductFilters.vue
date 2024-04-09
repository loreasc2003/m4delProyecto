<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useEcomStore } from '@/stores/apps/eCommerce';

const panel = ref([0, 1, 2, 3, 4]);
const priceSort = [
    {
        label: '$10 - $50',
        price: '50'
    },
    {
        label: '$50 - $100',
        price: '100'
    },
    {
        label: '$100 - $150',
        price: '151'
    },
    {
        label: '$150 - $200',
        price: '200'
    },
    {
        label: 'Over $200',
        price: '250'
    }
];

const store = useEcomStore();

//Reset Filter
store.filterReset();

const selectedGender = ref('');
store.SelectGender(selectedGender);

const selectedCategory = ref('all');
store.SelectCategory(selectedCategory);

const selectPrice = ref('');
store.SelectPrice(selectPrice);

const selectRating = ref(1);

onMounted(() => {
    store.fetchProducts();
});

const getProducts = computed(() => {
    return store.products;
});
const getUniqueData = (data: any, attr: any) => {
    let newVal = data.map((curElem: any) => {
        return curElem[attr];
    });
    if (attr === 'colors') {
        newVal = newVal.flat();
    }

    return (newVal = [...Array.from(new Set(newVal))]);
};

const filterbyColors: any = computed(() => {
    return getUniqueData(getProducts.value, 'colors');
});


//Reset Filter Function
function filterReset() {
    store.SelectGender('');
    store.SelectCategory('all');
    store.SelectPrice('');
    store.sortByColor('All');
}



</script>
<template>
    <v-sheet class="pa-4 pt-1">
        <v-expansion-panels v-model="panel" multiple>
            
            <v-expansion-panel elevation="0">
                <v-expansion-panel-title class="font-weight-medium custom-accordion"> Categorias </v-expansion-panel-title>
                <v-expansion-panel-text class="acco-body">
                    <v-row no-gutters>
                        <v-col cols="12">
                            <v-checkbox label="Todos" v-model="selectedCategory" color="primary" value="all" hide-details> </v-checkbox>
                        </v-col>
                        <v-col cols="12">
                            <v-checkbox
                                label="Suplementos"
                                v-model="selectedCategory"
                                color="primary"
                                value="kitchen"
                                hide-details
                            ></v-checkbox>
                        </v-col>
                        <v-col cols="12">
                            <v-checkbox
                                label="Accesorios de entrenamiento"
                                v-model="selectedCategory"
                                color="primary"
                                value="electronics"
                                hide-details
                            ></v-checkbox>
                        </v-col>
                        <v-col cols="12">
                            <v-checkbox label="Equipos de entrenamiento de fuerza" v-model="selectedCategory" color="primary" value="books" hide-details></v-checkbox>
                        </v-col>
                        <v-col cols="12">
                            <v-checkbox
                                label="Ropa y calzado deportivo"
                                v-model="selectedCategory"
                                color="primary"
                                value="fashion"
                                hide-details
                            ></v-checkbox>
                        </v-col>
                        
                    </v-row>
                </v-expansion-panel-text>
            </v-expansion-panel>
            <v-divider />
            
            <v-divider />
            <v-expansion-panel elevation="0">
                <v-expansion-panel-title class="font-weight-medium custom-accordion"> Precio </v-expansion-panel-title>
                <v-expansion-panel-text class="acco-body">
                    <v-radio-group v-model="selectPrice" class="custom-radio-box">    

                        <v-radio
                            v-for="pricing in priceSort"
                            :key="pricing.label"
                            :label="pricing.label"
                            v-model="selectPrice"
                            color="primary"
                            :value="pricing.price"
                            hide-details
                        >
                        </v-radio>
                    </v-radio-group>
                </v-expansion-panel-text>
            </v-expansion-panel>
            <v-divider />
            <v-expansion-panel elevation="0">
                <v-expansion-panel-title class="font-weight-medium custom-accordion"> Ranking </v-expansion-panel-title>
                <v-expansion-panel-text class="acco-body">
                    <v-rating hover color="warning" v-model="selectRating" class="ma-2" density="compact"></v-rating>
                </v-expansion-panel-text>
            </v-expansion-panel>
        </v-expansion-panels>
        <v-btn color="primary" @click="filterReset()"  block class="mt-5">Filtros</v-btn>
    </v-sheet>
</template>
<style lang="scss">
.custom-accordion {
    padding: 18px 2px;

    min-height: 30px !important;
    .v-expansion-panel-title__overlay {
        background-color: transparent;
    }
}
.acco-body {
    .v-expansion-panel-text__wrapper {
        padding: 5px 0;
    }
}
.custom-radio-box {
    .v-selection-control-group {
        flex-wrap: wrap;
    }
}

</style>
