const weatherAPIKey = 'b5398b545c29f1fcbab4a8badf25007b';
const metric = 'metric';
const imperial = 'imperial';
const celsius = 'C';
const fahrenheit = 'F';
const kelvin = 'K';
const degree = '\u00b0';
const iconUrlPrefix = 'https://openweathermap.org/img/wn/';
const iconUrlSuffix = '@2x.png';
const day = 'assets/images/evening.png';
const night = 'assets/images/night.png';
const iconPrefixName  = 'https://openweathermap.org/img/wn/';
const iconUrlSuffixx= '@2x.png';
DateTime localTime = DateTime.now();

final List<String> Cities = [
  "Dhaka", "Chittagong", "Khulna", "Rajshahi", "Sylhet",
  "Barisal", "Rangpur", "Mymensingh", "Comilla", "Narayanganj",
  "Gazipur", "Cox's Bazar", "Jessore", "Feni", "Bogra",
  "Kushtia", "Satkhira", "Pabna", "Noakhali", "Tangail",
  "Dinajpur", "Saidpur", "Nawabganj", "Patuakhali", "Jamalpur",
  "Narsingdi", "Lalmonirhat", "Sherpur", "Habiganj", "Chuadanga",
  "Thakurgaon", "Netrokona", "Gopalganj", "Kurigram", "Kishoreganj",
  "Manikganj", "Meherpur", "Narail", "Shariatpur", "Madaripur",
  "Brahmanbaria", "Bhola", "Lakshmipur", "Jhalokathi", "Munshiganj",
  "Magura", "Chandpur", "Pirojpur", "Bagerhat", "Sirajganj",
  "Joypurhat", "Gaibandha", "Nilphamari", "Panchagarh", "Maulvibazar",
  "Sunamganj", "Khagrachari", "Rangamati", "Bandarban", "Mymensingh",
  "Faridpur", "Tangail", "Manikganj", "Rajbari", "Chapai Nawabganj",
  "Khulna", "Satkhira", "Bagerhat", "Narail", "Jhenaidah",
  "Chuadanga", "Magura", "Kushtia", "Jessore", "Shariatpur",
  "Gopalganj", "Madaripur", "Barisal", "Pirojpur", "Bhola",
  "Barguna", "Jhalokathi", "Patuakhali", "Lalmonirhat", "Dinajpur",
  "Thakurgaon", "Gaibandha", "Kurigram", "Panchagarh", "Joypurhat",
  "Tangail", "Sherpur", "Narsingdi", "Munshiganj", "Brahmanbaria",
  "Lakshmipur", "Noakhali", "Feni", "Chandpur", "Moulvibazar",
  "Sunamganj", "Habiganj", "Pabna", "Natore",
  "New York", "Los Angeles", "Tokyo", "London", "Paris",
  "Berlin", "Rome", "Sydney", "Toronto", "Dubai",
  "Singapore", "Hong Kong", "Moscow", "Istanbul", "Beijing",
  "Seoul", "Bangkok", "Mumbai", "Jakarta", "Mexico City",
  "Lagos", "Cairo", "Buenos Aires", "Sao Paulo", "Rio de Janeiro",
  "Johannesburg", "Cape Town", "Nairobi", "Lima", "Kuala Lumpur",
  "Melbourne", "Vancouver", "Chicago", "San Francisco", "Washington D.C.",
  "Miami", "Houston", "Madrid", "Barcelona", "Lisbon",
  "Amsterdam", "Brussels", "Vienna", "Zurich", "Stockholm",
  "Oslo", "Helsinki", "Copenhagen", "Warsaw", "Prague",
  "Budapest", "Athens", "Dublin", "Edinburgh", "Manchester",
  "Glasgow", "Birmingham", "Leeds", "Newcastle", "Belfast",
  "Sheffield", "Nottingham", "Leicester", "Bristol", "Cardiff",
  "Santiago", "Bogota", "Caracas", "Quito", "Lima",
  "Montevideo", "Asuncion", "La Paz", "Sucre", "Havana",
  "Panama City", "San Jose", "Kingston", "Port-au-Prince", "San Salvador",
  "Managua", "Guatemala City", "Tegucigalpa", "Belmopan", "Ottawa",
  "Montreal", "Quebec City", "Edmonton", "Calgary", "Winnipeg",
  "Detroit", "Boston", "Dallas", "Phoenix", "Philadelphia",
  "Atlanta", "Denver", "Seattle", "San Diego", "Las Vegas"
];

