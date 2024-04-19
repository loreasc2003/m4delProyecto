<script setup>
import { computed, nextTick, ref, watch } from 'vue';
import BaseBreadcrumb from '@/components/shared/BaseBreadcrumb.vue';
import UiParentCard from '@/components/shared/UiParentCard.vue';
const page = ref({ title: 'CRUD' });
const breadcrumbs = ref([
    {
        text: 'Dashboard',
        disabled: false,
        href: '#'
    },
    {
        text: 'Tabla CRUD De Productos',
        disabled: true,
        href: '#'
    }
]);

const dialog = ref(false)
const dialogDelete = ref(false)
const headers = ref([
    {
        title: 'Nombre del Producto',
        align: 'start',
        sortable: false,
        key: 'name',
    },
    { title: 'Precio', key: 'calories' },
    { title: 'Precio en Tienda', key: 'fat' },
    { title: 'Status', key: 'carbs' },
    // { title: 'Actualizado', key: 'protein' },
    { title: 'Actions', key: 'actions', sortable: false },
])
const desserts = ref([])
const editedIndex = ref(-1)
const editedItem = ref({
    name: '',
    calories: 0,
    fat: 0,
    carbs: 0,
    protein: 0,
})
const defaultItem = ref({
    name: '',
    calories: 0,
    fat: 0,
    carbs: 0,
    protein: 0,
})
const formTitle = computed(() => {
    return editedIndex.value === -1 ? 'Nuevo Producto' : 'Editar'
})
function initialize() {
    desserts.value = [
        {
            name: 'Cinturones de levantamiento de pesas',
            calories: 175,
            fat: 200,
            carbs:  "En stok",
            // protein: 4,
        },
        {
            name: 'Equipos Cardiovasculares',
            calories: 81,
            fat: 89,
            carbs: "Sin stok",
            // protein: 4.3,
        },
        {
            name: 'Paquete de suplementos nutricionales',
            calories: 49.9,
            fat: 85,
            carbs: "En stok",
            // protein: 6,
        },
        {
            name: 'Suplemento con vitamina C',
            calories: 29,
            fat: 36,
            carbs: "sin stok",
            // protein: 4.3,
        },
        {
            name: 'Mancuernas Blue',
            calories: 12,
            fat: 15,
            carbs: "En stok",
            // protein: 3.9,
        },
        {
            name: 'Equipos de entranamiento de fuerza y agilidad',
            calories: 86,
            fat: 99,
            carbs: "En stok",
            // protein: 0,
        },
        {
            name: 'Pelota gris, Yoga',
            calories: 14.59,
            fat: 16,
            carbs: "Sin stok",
            // protein: 0,
        },
        {
            name: 'Pesas libres',
            calories: 105,
            fat: 130,
            carbs: "En stok",
            // protein: 6.5,
        },

    ]
}
function editItem(item) {
    editedIndex.value = desserts.value.indexOf(item)
    editedItem.value = Object.assign({}, item)
    dialog.value = true
}
function deleteItem(item) {
    editedIndex.value = desserts.value.indexOf(item)
    editedItem.value = Object.assign({}, item)
    dialogDelete.value = true
}
function deleteItemConfirm() {
    desserts.value.splice(editedIndex.value, 1)
    closeDelete()
}
function close() {
    dialog.value = false
    nextTick(() => {
        editedItem.value = Object.assign({}, defaultItem.value)
        editedIndex.value = -1
    })
}
function closeDelete() {
    dialogDelete.value = false
    nextTick(() => {
        editedItem.value = Object.assign({}, defaultItem.value)
        editedIndex.value = -1
    })
}
function save() {
    if (editedIndex.value > -1) {
        Object.assign(desserts.value[editedIndex.value], editedItem.value)
    } else {
        desserts.value.push(editedItem.value)
    }
    close()
}
watch(dialog, val => {
    val || close()
})
watch(dialogDelete, val => {
    val || closeDelete()
})
initialize()
</script>

<template>
    <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb>
    <v-row>
        <v-col cols="12">
            <UiParentCard title="">
                <v-data-table class="border rounded-md" :headers="headers" :items="desserts" :sort-by="[{ key: 'calories', order: 'asc' }]">
                    <template v-slot:top>
                        <v-toolbar class="bg-lightprimary rounded-t-md" flat>
                            <v-toolbar-title>Productos</v-toolbar-title>
                            <v-spacer></v-spacer>
                            <v-dialog v-model="dialog" max-width="500px">
                                <template v-slot:activator="{ props }">
                                    <v-btn color="primary"  variant="flat" dark  v-bind="props" >Agregar</v-btn>
                                </template>
                                <v-card>
                                    <v-card-title class="pa-4 bg-secondary">
                                        <span class="text-h5">{{ formTitle }}</span>
                                    </v-card-title>

                                    <v-card-text>
                                        <v-container class="px-0">
                                            <v-row>
                                                <v-col cols="12" sm="6" md="4">
                                                    <v-text-field v-model="editedItem.name"
                                                        label="Nombre De Producto"></v-text-field>
                                                </v-col>
                                                <v-col cols="12" sm="6" md="4">
                                                    <v-text-field v-model="editedItem.calories"
                                                        label="Precio"></v-text-field>
                                                </v-col>
                                                <v-col cols="12" sm="6" md="4">
                                                    <v-text-field v-model="editedItem.fat" label="Precio En Tienda"></v-text-field>
                                                </v-col>
                                                <v-col cols="12" sm="6" md="4">
                                                    <v-text-field v-model="editedItem.carbs"
                                                        label="Status"></v-text-field>
                                                </v-col>
                                                <!-- <v-col cols="12" sm="6" md="4">
                                                    <v-text-field v-model="editedItem.protein"
                                                        label="Status"></v-text-field>
                                                </v-col> -->
                                            </v-row>
                                        </v-container>
                                    </v-card-text>

                                    <v-card-actions>
                                        <v-spacer></v-spacer>
                                        <v-btn color="error" variant="flat" dark   @click="close">
                                            Cancel
                                        </v-btn>
                                        <v-btn color="success" variant="flat" dark   @click="save">
                                            Save
                                        </v-btn>
                                    </v-card-actions>
                                </v-card>
                            </v-dialog>
                            <v-dialog v-model="dialogDelete" max-width="500px">
                                <v-card>
                                    <v-card-title class="text-h5 text-center py-6">¿Estás seguro de que quieres eliminar este artículo?</v-card-title>
                                    <v-card-actions>
                                        <v-spacer></v-spacer>
                                        <v-btn color="error" variant="flat" dark   @click="closeDelete">Cancel</v-btn>
                                        <v-btn color="success" variant="flat" dark   @click="deleteItemConfirm">OK</v-btn>
                                        <v-spacer></v-spacer>
                                    </v-card-actions>
                                </v-card>
                            </v-dialog>
                        </v-toolbar>
                    </template>
                    <template v-slot:item.actions="{ item }">
                        <v-icon color="info" size="small" class="me-2" @click="editItem(item)">
                            mdi-pencil
                        </v-icon>
                        <v-icon color="error" size="small" @click="deleteItem(item)">
                            mdi-delete
                        </v-icon>
                    </template>
                    <template v-slot:no-data>
                        <v-btn color="primary" @click="initialize">
                            Reset
                        </v-btn>
                    </template>
                </v-data-table>
            </UiParentCard>
        </v-col>
    </v-row>
</template>
  
  