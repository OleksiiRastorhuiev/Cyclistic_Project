# CYCLISTIC BIKE SHARE PROJECT

# Introduction
This case study is a capstone project for the Google Data Analytics Professional Certificate on Coursera. In this case study, I will be analyzing the data from the fictional company Cyclistic. During this process, I will follow the steps of data analysis: ask, prepare, process, analyze, share, and act to answer business questions.

# Background
Cyclistic is a bike share company based in Chicago, which successfully launched its program in 2016. Since then, the program has grown to a fleet of 5,824 bicycles with geotracking capability and a network of 692 stations across the city. The bikes can be rented from a station and returned to any station from the system regardless of time. 

To date, the company's marketing strategy has focused primarily on building general awareness and a broad customer segmentation. Cyclistic Company offered the flexibility of pricing plans, including: single ride passes, full day passes, and annual memberships. Single-ride or full-day passes are for casual riders. Annual membership customers are members. 

According to financial analysts, annual members are considered more profitable for the company than casual riders. Even though the pricing flexibility attracts more riders, the manager believes that maximizing the number of annual members is critical for future growth. Instead of creating a marketing campaign to attract new customers, there is a promising potential to convert casual users into members.


# Approach

## 1. Ask
The goal is clear: develop marketing strategies to convert casual riders into members. To do this, it is important to understand the differences between members and casual riders and identify trends.

> Questions for future marketing program:

  > 1. How do annual members and casual riders use Cyclistic bikes differently?
  > 2. Why would casual riders buy a Cyclistic annual membership?
  > 3. How can Cyclistic use digital media to encourage casual riders to become members?

## 2. Prepare
We will analyze the historical trip data in order to identify trends. The data of the fictitious company Cyclistic can be downloaded [here](https://divvy-tripdata.s3.amazonaws.com/index.html). This trip data is available through [licence](https://divvybikes.com/data-license-agreement) from Motivate International Inc.
This is a public data that can be used to explore how different a customer type is. 

**Selected tools:**
* Data Processing
  * MySQL (for 12 months from 2023)
  * Python (for 6 months in 2023)
* Data Visualization:
  * Power BI (for 12 months period of 2023)
  * Python (for 6 months period of 2023)

Different tools for data analysis make it possible to present insights in the most appropriate way for the audience. 
This README focuses on the MYSQL and Power BI tool. Please click [here](Python_ScriptCyclistic.ipynb) to see this project performed in Python.

## 3. Process
**Data combining**
MySQL was used for data cleaning and data merging for 12 months period into one dataset. The reason for this is the sheer volume of data processed (about 6.5 million rows). Spreadsheet programs such as Excel or Google Sheet might be suitable for smaller datasets with no more than 1 048 576 rows. That's why SQL is a better choice.

After creating a combined tripdata table, the total number of rows was 6,491,571.
**Data exploration**
After creating a new combined table, I ran querries in order to find outliers, errors, blank rows, missing values.
The schema of table:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/38f610cb-c4de-4966-8d0d-4583e2a875dc"
width="217">

Total number of rows:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/1d67f425-638d-4e13-8975-68bcefda5d26"
width="136" >

Number of duplicates based on ride_id column:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/390aa029-6b95-4c8d-83d5-7aa95e3a43f2"
width="125">


**Data cleaning**

 * Removes duplicate, blank, null, negative, and outlier data (trip duration > 24 hours)
 * Add new columns: duration_minutes, day_of_week, day_name, month_name, hour_started

First, we create a table without duplicates in ride_id. Then we find the total number of rows:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/724bbf00-b86d-4114-be7d-7680900834c4"
  width="204">

Check for duplicates:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/8d324ca8-bb46-4364-91dd-c6d2321d2bed"
width="164">

Total number of blank or null rows in columns:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/9176d28b-fa3e-4d5d-82ff-2540712f58c7"
width="156">

Distribution of the number of blank values between columns:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/c4894258-e260-4a02-9189-547d801e5d45"
width="246">

Delete blank values from affected columns:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/927746f0-46f5-4c81-a47b-455ac7bf63a9"
width="141">


Total number of rows returned after cleanup:
 
<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/432038ca-ff5d-4d22-acf0-cc0756750ceb"
width="170" >
 
This means that 2,159,867 rows of "bad data" have been removed. 
Outliers are removed after inserting a travel time column.
After adding new columns, let's find the number of outliers: trip duration less <= 0 minutes and >= 24 hours.

Number of negative values and 0:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/e8b41f46-5e87-4b24-8c81-8cbd5400c002"
width="215" >

Number of trips greater than or equal to 24 hours (1440 minutes):

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/4e840bd7-7715-4c7e-929e-e0ba06d14738"
width="138">

Delete null and negative values in the Duration column:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/716380f7-cd26-44b8-815a-78f0be2ecde2"
width="128">

Deletion of rides equal to or longer than 24 hours:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/be967a22-2185-450b-8a25-aef250016245"
width="116">

Check to see if Outliers are deleted:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/f745f9cb-4d77-4585-84a1-4e17b454800d"
width="346">


## 4. Data Analysis & Sharing

Cleaned data visualized with Power BI
Answer to question 1 

Total number of trips by user type in 2023:

<img  alt="20_number_rides_usertype" src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/73058dbd-ecd7-4489-b30d-e07a6e11ec3d"
width="258">

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/1aeb187c-c55f-4005-89f4-383107f322b7"
width="200">

It can be seen that the share of casual users is larger than that of members. Therefore, understanding the differences between the two groups is crucial for a successful marketing campaign.

Preferred bike type among users:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/e28369ec-bfe4-439c-a44c-568c07099621"
width="333">

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/b36899b1-b7e7-431f-98e5-930525ef2626"
width="219">

The classic bicycle is an absolute favorite among members and casual riders. Electric bicycles were less preferred by both groups. Although docked bikes were ridden by casual riders (especially during the summer), their share was small.

Average ride time for members and occasional riders:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/7deb5be3-d8af-4a72-9d8e-94afd37b185f"
width="191">

Average trip duration was 12 minutes for members and 23 minutes for occasional riders. Apparently, this can be explained by the higher magnitude of ride duration for casual riders.

Distribution of average trip duration by month and user:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/2dbec493-d240-4f59-9465-dfbe709b4143"
width="338">

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/d49e33d2-910a-4685-9d08-7e0744e9278e"
width="292" >

It seems that the average ride duration for member users tends to be more stable, while this value is higher for casual riders (perhaps due to seasonality).

Number of rides by month and user type:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/4e932b9b-9ae9-4f1d-8060-1274780acc25"
width="429">

For both types of riders, the number of trips increases in the summer. This can be explained by seasonality (longer day length, temperature, better weather).

Number of rides by day of week and user type:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/e2e4eed4-6b56-49d9-9fd9-707718ef702f"
width="429">

The distribution of number of rides differs for member and casual users. In general, member riders had a more even distribution of rides, and casual riders had more obvious peaks. The beginning of the week was busier for member riders. Casual riders tended to ride more on the weekend. This could be explained by the different priorities of member and casual users: members could rent a bike for work, while casual users would use it for vacation or hobby.

Number of rides by hour and user type:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/0d2bbd68-a3d8-40d3-a047-e2069626ea2e"
width="429">

It can be seen that the busiest times (peaks) for member riders were 8 o'clock and 5 o'clock. The explanation for this could be that member users rent a bike to get to work. For casual riders, there weren't any "busy" hours - renting time was more evenly distributed among users without annual memberships. 
 
Top 10 start station names for members:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/656f5ccd-2750-4309-8869-418700cf20ec"
width="429">

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/2db06e90-1383-438f-ad3f-48af728d1d2f"
width="348">

Top 10 places to start for casual riders:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/a225be68-68a3-44c3-9ad9-a491c77bd4a7"
width="429">

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/82395c7f-157b-4d56-9d61-9e0e0da7743d"
width="348">

Dashboard:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/e1d11404-d382-4a64-a6af-e37f2a85ffcd"
width="999">

Top 10 Start and End Stations for Members and Casuals:

<img src="https://github.com/OleksiiRastorhuiev/Cyclist_project/assets/162378596/f88c12c2-927a-4f17-8436-0c7cd32fdb08"
width="999">

## 5. Act
**Differences in the use of bicycles by annual members and casual riders:**

* Ride Duration: 
  * Average ride duration was higher for casual riders than for members. 
  * The distribution of average duration by month was more even for members, while casuals tended to change more quickly.
    
* Preferred bike type:
  * Classic bike was the most popular type for members and casual riders.
  * Electric type was less popular.
  * Docked bicycle was rented only by casual riders, but the share was minor.

* Ride Frequency:
  * **by month:** For both groups the busiest time was in summer (especially in August) with the second peak in September and the third increase in May. During the other months, the number of trips tended to decrease, with the lowest value in February.       It seems that the higher demand for bicycle trips for both types of users in summer could be explained by the holiday season, better weather and longer day length. The decline from mid-fall to late winter could be due to poorer weather conditions and shorter days.
  * **by day of week:** For members, Wednesday, Thursday and Tuesday were the busiest days, and Sunday was the least busy.
    for casual users: Saturday, Sunday and Friday are the busiest days for casual users. The beginning of the week was the least busy.
  * **by hour:** The highest numbers of member riders were at 8 o'clock and 5 o'clock. This could be explained by the fact that members rent a bike to get to work. For casual riders, there weren't any "busy" hours - renting time was more evenly distributed among non-members.
    
* Starting and Ending Stations: Members rented bikes mostly for work, casual preferred mostly for recreation.

**Why would casual users buy an annual membership to Cyclistic?**
- **Save money:** For an annual membership, a monthly price is cheaper than a one-time bike rental.
- **Ride together:** Extra discount for members who recommend annual membership to friends, colleagues.
- **Best routes:** Suggestion of recommended routes for members to take.
- **After the ride:** Discounted or complimentary snacks and drinks.
- **Extra value:** Special events for members.

**Digital media to convert casual riders into members**
- Target casual riders at the most popular stations.
- The best time to sign up for an annual membership is spring - early summer.
- Social media posts and articles about the lasting benefits of regular rides for health, cycling as a hobby, spending time with friends, team building with colleagues. 
