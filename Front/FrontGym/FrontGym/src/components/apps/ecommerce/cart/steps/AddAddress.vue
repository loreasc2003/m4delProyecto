<script setup lang="ts">
import { ref,computed } from 'vue';
import { Form } from 'vee-validate';

const dialog = ref(false)
const name = ref('');
const inline = ref('home');
const isdefault = ref(false);
const rules: any = ref({
    name: (value: string) => value.length > 2 || 'More than two letters required'
});
</script>

<template>
    <v-dialog v-model="dialog"  activator="parent" max-width="600">
        <v-card>
            <v-card-text>
                <div class="d-flex justify-space-between">
                    <h3 class="text-h3">Agregar dirección de facturación</h3>
                    <v-btn icon @click="dialog = false"  size="small" flat><XIcon size="16" /></v-btn>
                </div>
            </v-card-text>
            <v-divider></v-divider>
            <v-card-text>
                <Form class="py-3">
                    <v-row>
                        <v-col cols="12" lg="6">
                            <v-text-field
                                v-model="name"
                                :rules="[rules.required, rules.name]"
                                label="Primer nombre"
                                variant="outlined"
                                hide-details="auto"
                                :color="name.length > 2 ? 'success' : 'primary'"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" lg="6">
                            <v-radio-group v-model="inline" inline hide-details="auto">
                                <v-radio label="Hogar" value="home" color="primary"></v-radio>
                                <v-radio label="Oficina" value="office" color="secondary"></v-radio>
                            </v-radio-group>
                        </v-col>
                        <v-col cols="12" lg="12">
                            <v-text-field
                                v-model="name"
                                :rules="[rules.required, rules.name]"
                                label="No. de edificio"
                                hide-details="auto"
                                variant="outlined"
                                :color="name.length > 2 ? 'success' : 'primary'"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" lg="12">
                            <v-text-field
                                v-model="name"
                                :rules="[rules.required, rules.name]"
                                label="Calle"
                                variant="outlined"
                                hide-details="auto"
                                :color="name.length > 2 ? 'success' : 'primary'"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" lg="6">
                            <v-text-field
                                v-model="name"
                                :rules="[rules.required, rules.name]"
                                label="Ciudad"
                                variant="outlined"
                                hide-details="auto"
                                :color="name.length > 2 ? 'success' : 'primary'"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" lg="6">
                            <v-text-field
                                v-model="name"
                                :rules="[rules.required, rules.name]"
                                label="Estado"
                                variant="outlined"
                                hide-details="auto"
                                :color="name.length > 2 ? 'success' : 'primary'"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" lg="6">
                            <v-text-field
                                v-model="name"
                                :rules="[rules.required, rules.name]"
                                label="País"
                                variant="outlined"
                                hide-details="auto"
                                :color="name.length > 2 ? 'success' : 'primary'"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" lg="6">
                            <v-text-field
                                v-model="name"
                                :rules="[rules.required, rules.name]"
                                label="C.P"
                                variant="outlined"
                                hide-details="auto"
                                :color="name.length > 2 ? 'success' : 'primary'"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" lg="12">
                            <v-text-field
                                v-model="name"
                                :rules="[rules.required, rules.name]"
                                label="Contacto"
                                variant="outlined"
                                hide-details="auto"
                                :color="name.length > 2 ? 'success' : 'primary'"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" lg="12">
                            <v-switch v-model="isdefault" label="Default"></v-switch>
                        </v-col>
                        <v-col cols="12" lg="12" class="text-right">
                            <v-btn color="error" type="submit" variant="text">Cancelar</v-btn>
                            <v-btn color="primary" type="submit">Aceptar</v-btn>
                        </v-col>
                    </v-row>
                </Form>
            </v-card-text>
        </v-card>
    </v-dialog>
</template>