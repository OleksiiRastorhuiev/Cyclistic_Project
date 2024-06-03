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
This README focuses on the MYSQL and Power BI tool. Please click [here](Python_Script_Cyclistic.ipynb) to see this project performed in Python.

## 3. Process
**Data combining**
MySQL was used for data cleaning and data merging for 12 months period into one dataset. The reason for this is the sheer volume of data processed (about 6.5 million rows). Spreadsheet programs such as Excel or Google Sheet might be suitable for smaller datasets with no more than 1 048 576 rows. That's why SQL is a better choice.

After creating a combined tripdata table, the total number of rows was 6,491,571.
**Data exploration**
After creating a new combined table, I ran querries in order to find outliers, errors, blank rows, missing values.
The schema of table:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/6996d496-103d-45fb-b8d6-06c4a26a91ba"
width="217" >

Total number of rows:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/bc934436-f3ae-4d8e-a5c6-1abf6397939f"
width="136" >

Number of duplicates based on ride_id column:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/7bd6e711-4684-4632-80e1-101fe252600f"
width="125">


**Data cleaning**

 * Removes duplicate, blank, null, negative, and outlier data (trip duration > 24 hours)
 * Add new columns: duration_minutes, day_of_week, day_name, month_name, hour_started

First, we create a table without duplicates in ride_id. Then we find the total number of rows:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/c25678f6-6972-4532-82ca-74e662b9b16d"
width="204">

Check for duplicates:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/1dc74f6b-7453-4537-82c4-403241c88a0b"
width="164">

Total number of blank or null rows in columns:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/aa973a48-4895-4480-9ce0-7865c991aa32"
width="156">

Distribution of the number of blank values between columns:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/32846ef5-4716-417a-8fd0-3d30f1d3121f"
width="246">

Delete blank values from affected columns:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/21b161e5-e298-4328-8542-f5e5c70f30d5"
width="141">

Total number of rows returned after cleanup:
 

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/8251530a-e7ce-4461-ab1b-f7a102d9cdbb"
width="170">

This means that 2,159,867 rows of "bad data" have been removed. 
Outliers are removed after inserting a travel time column.
After adding new columns, let's find the number of outliers: trip duration less <= 0 minutes and >= 24 hours.

Number of negative values and 0:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/32f3a370-933d-4635-937a-4b39c886c351"
width="215" >

Number of trips greater than or equal to 24 hours (1440 minutes):

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/d45299e0-a19f-435f-882c-f520b4001ad1"
width="138">

Delete null and negative values in the Duration column:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/e324e9d4-4d95-4def-9972-23971dcfe2e4"
width="128">

Deletion of rides equal to or longer than 24 hours:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/c77db241-7e1f-4800-bc45-f90cc98879f8"
width="116">

Check to see if Outliers are deleted:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/4f3e7fd1-0a5e-446d-849e-3fd566f4ddd5"
width="346">


## 4. Data Analysis & Sharing

Cleaned data visualized with Power BI
Answer to question 1 

Total number of trips by user type in 2023:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/5fa17e22-a8c5-4ef9-be71-0cab6c0a4218"
width="258">

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/1668aaf5-89d4-4b9c-a7de-47c57686f9b1"
width="200">

It can be seen that the share of casual users is larger than that of members. Therefore, understanding the differences between the two groups is crucial for a successful marketing campaign.

Preferred bike type among users:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/3e6c6d11-476e-4957-96b2-7eb27562efba"
width="333">

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/ec52faa8-0890-47a4-a431-509f6b082dcd"
width="219">

The classic bicycle is an absolute favorite among members and casual riders. Electric bicycles were less preferred by both groups. Although docked bikes were ridden by casual riders (especially during the summer), their share was small.

Average ride time for members and occasional riders:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/2fbc4d20-15ff-4dbe-afa9-5e365e5ddf9a"
width="191">

Average trip duration was 12 minutes for members and 23 minutes for occasional riders. Apparently, this can be explained by the higher magnitude of ride duration for casual riders.

Distribution of average trip duration by month and user:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/223de844-9751-4d41-b270-1b745cf34ff8"
width="338">

<img alt="17_month_avg_duration_by_user" src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/29b8c931-381a-4f86-9c53-271573fcf334"
width="292">

It seems that the average ride duration for member users tends to be more stable, while this value is higher for casual riders (perhaps due to seasonality).

Number of rides by month and user type:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/b1c16b59-8b5d-442f-a967-ba40a5f3aa4b"
width="429">

For both types of riders, the number of trips increases in the summer. This can be explained by seasonality (longer day length, temperature, better weather).

Number of rides by day of week and user type:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/5fcec6a3-d620-4784-ad88-23f8ac74e612"
width="429">

The distribution of number of rides differs for member and casual users. In general, member riders had a more even distribution of rides, and casual riders had more obvious peaks. The beginning of the week was busier for member riders. Casual riders tended to ride more on the weekend. This could be explained by the different priorities of member and casual users: members could rent a bike for work, while casual users would use it for vacation or hobby.

Number of rides by hour and user type:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/1c558a5f-4c3a-442e-bf72-370931b956a8"
width="319">

It can be seen that the busiest times (peaks) for member riders were 8 o'clock and 5 o'clock. The explanation for this could be that member users rent a bike to get to work. For casual riders, there weren't any "busy" hours - renting time was more evenly distributed among users without annual memberships. 
 
Top 10 start station names for members:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/9a11631a-297f-425f-9b51-0e6a818e310c"
width="429">

<img alt="18_top10_stations_member" src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/968ff938-eb7c-4ae5-8b2e-aad4c9c32fff"
width="348">

Top 10 places to start for casual riders:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/e4d8f3dd-cf2c-432e-a7c7-6d481b7d56a0"
width="429">

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/dcd29983-55c0-443c-aa9b-02baaacdc45a"
width="348">

Dashboard:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/650883cc-3799-481f-bb17-187f8f0eab28"
width="999">

Top 10 Start and End Stations for Members and Casuals:

<img src="https://github.com/OleksiiRastorhuiev/Cyclistic_Project/assets/162378596/94e1b968-e0f6-4a56-9080-7c598b5c7764"
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
  * **by month:** For both groups the busiest time was in summer (especially in August) with the second peak in September and the third increase in May. During the other months, the number of trips tended to decrease, with the lowest value in February. It seems that the higher demand for bicycle trips for both types of users in summer could be explained by the holiday season, better weather and longer day length. The decline from mid-fall to late winter could be due to poorer weather conditions and shorter days.
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
