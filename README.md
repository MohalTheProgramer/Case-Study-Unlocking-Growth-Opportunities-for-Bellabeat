# Case-Study-Unlocking-Growth-Opportunities-for-Bellabeat

**Role:** Data Analyst | **Tools:** R | **Date:** January 2026
# 1. Executive Summary
Bellabeat, a high-tech manufacturer of health-focused products for women, sought to analyze smart device usage trends to guide their marketing strategy. By analyzing public Fitbit data, I discovered key patterns in user activity, sleep efficiency, and device retention. My final recommendations focus on a "Fashion-First" retention strategy and time-based notifications to capitalize on peak activity windows.
# 2. The Business Task
Goal: Analyze smart device usage data to gain insight into how consumers use non-Bellabeat smart devices and apply these trends to Bellabeat's marketing strategy. Stakeholders: 
Urška Sršen (CCO)
Sando Mur (Co-founder)
Marketing Analytics Team.
# 3. Data Source & Quality (Prepare Phase)
I utilized the FitBit Fitness Tracker Data (Public Domain via Kaggle/Mobius).
Limitations: The dataset contains a small sample size (33 unique users) and is from 2016. Crucially, gender is not specified. Since Bellabeat targets women, I analyzed this data as a proxy for general fitness behavior while noting the demographic bias.
Data Integrity: Validated using the ROCCC framework. While the data is cited and open-source, its reliability is low due to the small sample size.
# 4. Key Insights & Visualizations

## Insight 1: The "Evening Peak" & "3 PM Slump"
Analysis of hourly data reveals that users are most active between 5:00 PM and 7:00 PM, likely after work. Conversely, there is a consistent dip in activity around 3:00 PM. 
![Bar chart](https://drive.google.com/file/d/1I76wtusJ2dcRzWHIajwY9V6zXsVRJ_Z8/view?usp=drive_link)
## Insight 2: Sleep Efficiency Gaps
There is a strong linear correlation between time in bed and time asleep. However, significant outliers indicate users often spend 30-60+ minutes awake in bed, signaling potential opportunities for sleep aid features.
![LIne chart](https://drive.google.com/file/d/1Rdcpv5w80NvUJKEMwgtcJIieEq6Ygqta/view?usp=drive_link)
## Insight 3: The Retention Challenge
Usage data shows a polarized behavior: 50% of users wear the device consistently (21+ days/month), while 38% abandon it quickly (using it <10 days/month). This suggests a comfort or aesthetic barrier to daily wear. 
![Pie chart](https://drive.google.com/file/d/18p-bkDQyO0jCFmQN-twl6-e3mSnP3bcQ/view?usp=drive_link)
## 5. Strategic Recommendations (Act Phase)
Based on the analysis, I propose the following strategies for the Bellabeat marketing team:
Notification Strategy: Program the Bellabeat app to send high-energy workout reminders at 4:30 PM to align with the natural activity peak. Conversely, use the 3:00 PM slump to suggest low-effort wellness activities like breathing exercises or hydration.

Position Bellabeat as a Sleep Solution: Address the **awake in bed** gap by marketing Bellabeat's ability to detect restlessness and automatically suggest soothing content (meditation/stories) to help users fall back asleep.
Fashion-First Retention Campaign: Tackle the high abandonment rate (38%) by highlighting Bellabeat's jewelry-like design. Marketing should emphasize comfort and style to encourage 24/7 wear, ensuring more complete health data.


