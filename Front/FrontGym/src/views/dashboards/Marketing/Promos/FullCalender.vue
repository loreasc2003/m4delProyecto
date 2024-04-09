<script>
import { defineComponent } from 'vue'
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'


let eventGuid = 0
let todayStr = new Date().toISOString().replace(/T.*$/, '') // YYYY-MM-DD of today

const today = new Date();
const y = today.getFullYear();
const m = today.getMonth();
const d = today.getDate();

export const INITIAL_EVENTS = [

  {
    id: createEventId(),
    title: 'Competencia de levantamiento de pesas a las 17:00.',
    allDay: true,
    start: new Date(y, m, 3),
    end: new Date(y, m, 5),
    color: '#615dff',
  },
  {
    id: createEventId(),
    title: ' Taller de nutrición y alimentación saludable a las 18:30.',
    start: new Date(y, m, d + 3, 10, 30),
    end: new Date(y, m, d + 3, 11, 30),
    allDay: true,
    color: '#39b69a',
  },
  {
    id: createEventId(),
    title: 'Competición de carrera de obstáculos a las 9:00.',
    start: new Date(y, m, d + 7, 12, 0),
    end: new Date(y, m, d + 7, 14, 0),
    allDay: true,
    color: '#fc4b6c',
  },
  {
    id: createEventId(),
    title: 'Clase de boxeo con entrenador profesional a las 19:00.',
    start: new Date(y, m, d - 2),
    end: new Date(y, m, d - 2),
    allDay: true,
    color: '#1a97f5',
  },
  {
    id: createEventId(),
    title: 'Desafío de circuito de ejercicios de alta intensidad (HIIT) a las 17:30.',
    start: new Date(y, m, d + 1, 19, 0),
    end: new Date(y, m, d + 1, 22, 30),
    allDay: true,
    color: '#1a97f5',
  },
  {
    id: createEventId(),
    title: 'Sesión de estiramiento y relajación a las 19:00.',
    start: new Date(y, m, 23),
    end: new Date(y, m, 25),
    color: '#fdd43f',
  },
  {
    id: createEventId(),
    title: 'Celebración del cierre de mes con un evento social y sorteos de premios a las 20:00.',
    start: new Date(y, m, 19),
    end: new Date(y, m, 22),
    color: '615dff',
  },
]

export function createEventId() {
  return String(eventGuid++)
}



export default defineComponent({
  components: {
    FullCalendar,
  },
  data() {
    return {
      updateModalShow: false,
      AddModal: false,
      calendarOptions: {
        plugins: [
          dayGridPlugin,
          timeGridPlugin,
          interactionPlugin // needed for dateClick
        ],
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        initialView: 'dayGridMonth',
        initialEvents: INITIAL_EVENTS, // alternatively, use the `events` setting to fetch from a feed
        editable: true,
        selectable: true,
        selectMirror: true,
        dayMaxEvents: true,
        weekends: true,
        select: this.handleDateSelect,
        eventClick: this.handleEventClick,
        eventsSet: this.handleEvents,
      },
      currentEvents: [],
    }
  },
  methods: {
    handleWeekendsToggle() {
      this.calendarOptions.weekends = !this.calendarOptions.weekends // update a property
    },
    handleDateSelect(selectInfo) {
      this.AddModal = true;
      const title ='Please enter a new title for your event'
      const calendarApi = selectInfo.view.calendar
      calendarApi.unselect() // clear date selection
      if (title) {
        calendarApi.addEvent({
          id: createEventId(),
          title,
          start: selectInfo.startStr,
          end: selectInfo.endStr,
          allDay: selectInfo.allDay
        })
      }
      
    },
    handleEventClick(clickInfo) {
      this.updateModalShow = true;
      // eventClick.clickInfo.event
    },
    handleEvents(events) {
      this.currentEvents = events;
    },
  }
})

</script>

<template>
  <div class='demo-app'>
    <div class='demo-app-main '>
      <FullCalendar class='demo-app-calendar rounded-md' :options='calendarOptions' >
        <template v-slot:eventContent='arg'>
          <div class="text-subtitle-1 pa-1 text-truncate">{{ arg.event.title }}</div>
        </template>
      </FullCalendar>
      <v-dialog v-model="updateModalShow" max-width="500px">
        <v-card>
          <v-card-text>
            <h4 class="text-h4">Update Event</h4>
            <p class="text-subtitle-1 textSecondary my-4">To Edit/Update Event kindly change the title and choose the event
              color and press the update button</p>
          </v-card-text>
        </v-card>
      </v-dialog>

      <v-dialog v-model="AddModal" max-width="500px">
        <v-card>
          <v-card-text>
            <h4 class="text-h4">Agregar evento</h4>
            <p class="text-subtitle-1 textSecondary  my-4">To add Event kindly fillup the title and choose the event color
              and press the add button</p>
        </v-card-text>
        </v-card>
      </v-dialog>
    </div>
  </div>
</template>

