import type { TablerIconComponent } from "vue-tabler-icons";
/*my contacts*/
type myContacts = {
    title: string;
    avatar: string;
    avatarstatus: string;
    desc: string;
};

type projectTable = {
    img: string;
    activestate: string;
    leadname: string;
    leademail: string;
    projectname: string;
    statuscolor: string;
    statustext: string;
    money: string;
}

type weeklyStates = {
    color: string,
    icon: TablerIconComponent;
    title: string,
    desc: string,
    percent: number,
}

type dailyActivities = {
    color: string,
    title: string,
    time: string
}


export type { myContacts, projectTable, weeklyStates, dailyActivities }