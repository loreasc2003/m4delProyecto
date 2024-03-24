import mock from '../../mockAdapter';

interface NotesType {
    id?: number | any;
    color?: string;
    title?: string;
    datef?: string | Date;
}

const NotesData: NotesType[] = [
    {
        id: 1,
        color: 'primary',
        title: 'Programas de afiliación o membresía: El gimnasio establece un acuerdo con una empresa, universidad u organización local para ofrecer descuentos o beneficios especiales a sus empleados o miembros. Los empleados o miembros de la empresa u organización afiliada pueden inscribirse en el gimnasio y recibir el beneficio acordado, que puede incluir descuentos en las tarifas de membresía, acceso a clases especiales, o beneficios adicionales como sesiones de entrenamiento gratuitas o evaluaciones físicas. Los empleados o miembros interesados generalmente deben presentar una identificación o prueba de afiliación a la empresa u organización para recibir el descuento o beneficio.',
        datef: '2023-06-03T23:28:56.782Z'
    },
    {
        id: 2,
        color: 'error',
        title: 'Programas de recompensas por lealtad:Ofrecen incentivos a los miembros que frecuentan regularmente el gimnasio, acumulando puntos o beneficios especiales que pueden canjear por servicios adicionales, productos o descuentos.',
        datef: '2023-06-02T23:28:56.782Z'
    },
    {
        id: 3,
        color: 'warning',
        title: 'Programas de eventos especiales: Organización de eventos especiales, como talleres de nutrición, competiciones de fitness, clases magistrales o seminarios, en colaboración con expertos en el campo del fitness y la salud.',
        datef: '2023-06-01T23:28:56.782Z'
    },
    {
        id: 4,
        color: 'success',
        title: 'Programas de entrenamiento personalizado: Asociación con entrenadores personales independientes que pueden ofrecer servicios de entrenamiento dentro del gimnasio a cambio de una comisión o tarifa de alquiler de espacio.',
        datef: '2023-06-03T23:28:56.782Z'
    }
];

interface colorVariationType {
    id?: number;
    color?: string;
}

export const colorVariation: colorVariationType[] = [
    {
        id: 1,
        color: 'warning'
    },
    {
        id: 2,
        color: 'secondary'
    },
    {
        id: 3,
        color: 'error'
    },
    {
        id: 4,
        color: 'success'
    },
    {
        id: 5,
        color: 'primary'
    }
];

mock.onGet('/api/data/notes/NotesData').reply(() => {
    return [200, NotesData];
});
export default NotesData;
