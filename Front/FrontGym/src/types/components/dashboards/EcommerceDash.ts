import type { TablerIconComponent } from "vue-tabler-icons";
type recentTransaction = {
    color: string;
    bgcolor: string;
    icon: TablerIconComponent;
    title: string;
    desc: string;
    price: string;
    status: string;
};

type productPerformance = {
    avatar: string;
    name: string;
    category: string;
    earn: string;
    percent: number;
}

type topCards = {
    color: string;
    bgcolor: string;
    icon: TablerIconComponent;
    title: string;
    desc: string;
    price: string;
    status: string;
}

export type {recentTransaction,productPerformance,topCards}