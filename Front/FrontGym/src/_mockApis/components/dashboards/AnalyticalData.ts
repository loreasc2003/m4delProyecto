import type { myContacts, projectTable, weeklyStates, dailyActivities } from '@/types/components/dashboards/AnalyticalDash';
import { MessageDotsIcon, ShoppingCartIcon, StarIcon } from 'vue-tabler-icons';
import img1 from '@/assets/images/profile/1.jpg';
import img2 from '@/assets/images/profile/2.jpg';
import img3 from '@/assets/images/profile/3.jpg';
import img4 from '@/assets/images/profile/4.jpg';
import img5 from '@/assets/images/profile/5.jpg';
/*--Blog Cards--*/
const myContactsData: myContacts[] = [
  {
    title: "Pavan Kumar",
    avatar: img1,
    avatarstatus: "success",
    desc: "info@wrappixel.com",
  },
  {
    title: "Sonu Nigam",
    avatar: img2,
    avatarstatus: "error",
    desc: "pamela1987@gmail.com",
  },
  {
    title: "Arijit singh",
    avatar: img3,
    avatarstatus: "warning",
    desc: "cruise1298.fiplip@gmail.com",
  },
  {
    title: "Pavan Kumar",
    avatar: img4,
    avatarstatus: "success",
    desc: "kat@gmail.com",
  },
];

const projectTableData: projectTable[] = [
  {
    img: img1,
    activestate: "",
    leadname: "Sunil Joshi",
    leademail: "Web Designer",
    projectname: "Elite Admin",
    statuscolor: "success",
    statustext: "Low",
    money: "$3.9K",
  },
  {
    img: img2,
    activestate: "active",
    leadname: "Andrew",
    leademail: "Project Manager",
    projectname: "Real Homes",
    statuscolor: "info",
    statustext: "Medium",
    money: "$23.9K",
  },
  {
    img: img3,
    activestate: "",
    leadname: "Bhavesh patel",
    leademail: "Developer",
    projectname: "MedicalPro Theme",
    statuscolor: "deep-purple accent-2 white--text",
    statustext: "High",
    money: "$12.9K",
  },
  {
    img: img4,
    activestate: "",
    leadname: "Nirav Joshi",
    leademail: "Frontend Eng",
    projectname: "Elite Admin",
    statuscolor: "error",
    statustext: "Low",
    money: "$10.9K",
  },
  {
    img: img5,
    activestate: "",
    leadname: "Micheal Doe",
    leademail: "Content Writer",
    projectname: "Helping Hands",
    statuscolor: "warning",
    statustext: "High",
    money: "$12.9K",
  },
];

const weeklyStatesData: weeklyStates[] = [
  {
    color: "primary",
    icon: ShoppingCartIcon,
    title: "Top Sales",
    desc: "Johnathan Doe",
    percent: 68,
  },
  {
    color: "warning",
    icon: StarIcon,
    title: "Best Seller",
    desc: "MaterialPro Admin",
    percent: 45,
  },
  {
    color: "success",
    icon: MessageDotsIcon,
    title: "Most Commented",
    desc: "Ample Admin",
    percent: 10,
  },
]

const dailyActivitiesData: dailyActivities[] = [
  {
    color: "success",
    title: "Meeting with John",
    time: "04.05 AM"
  },
  {
    color: "primary",
    title: "Payment received of $385.90",
    time: "04.25 AM"
  },
  {
    color: "secondary",
    title: "Project Meeting",
    time: "05.26 AM"
  },
  {
    color: "warning",
    title: "New Sale recorded #ML-3467",
    time: "05.12 AM"
  },
  {
    color: "error",
    title: "Payment was made to Michael",
    time: "06.23 AM"
  }

]

export { myContactsData, projectTableData, weeklyStatesData, dailyActivitiesData }