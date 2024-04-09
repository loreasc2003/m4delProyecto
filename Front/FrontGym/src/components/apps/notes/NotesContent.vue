<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useNoteStore } from '@/stores/apps/notes';
import { CheckIcon, Menu2Icon } from 'vue-tabler-icons';
import AddNote from './AddNote.vue';
import { colorVariation } from '@/_mockApis/apps/notes/index';

const store = useNoteStore();

onMounted(() => {
    store.fetchNotes();
});

const getNote = computed(() => {
    return store.notes[store.notesContent - 1];
});
// theme breadcrumb
</script>

<template>
    <!-- ---------------------------------------------------- -->
    <!-- Table Basic -->
    <!-- ---------------------------------------------------- -->

    <v-sheet>
        <v-sheet class="py-3 pl-6 pr-4 d-flex align-center">
            <h4 class="text-h6">Editar programa afiliado</h4>
            <div class="ml-auto"><AddNote /></div>
        </v-sheet>
        <v-divider></v-divider>
        <v-sheet v-if="getNote">
            <v-sheet class="pa-6">
                <h4 class="text-h6 mb-4">Programa afiliado</h4>
                <v-textarea outlined name="Note" v-model="getNote.title"></v-textarea>

                
            </v-sheet>
        </v-sheet>
        <v-sheet v-else class="pa-6"> <v-alert type="error" title="Opps" text="No Note selected Please select note"></v-alert></v-sheet>
    </v-sheet>
</template>
