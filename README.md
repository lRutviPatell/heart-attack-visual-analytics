# ❤️ Heart Attack Prediction – Data Visualization Project
### DSC465 – Data Visualization | DePaul University  
**Group 5 – Data Canvas**  
Rutvi Patel • Dhwani Patel • Yagnesh Patel • Sylvia Ozoede  
**Professor:** Eli Brown  
**Date:** November 19, 2025

---

## 📌 Project Overview
Heart attacks remain one of the leading causes of death worldwide. This project uses **data visualization** to explore complex relationships among demographic, clinical, lifestyle, and geographic variables affecting heart attack risk.

Using an 8,763-record dataset with complete multidimensional patient information, we created visualizations and an **interactive dashboard** to help uncover patterns that can support clinical decision-making, public health insights, and future predictive modeling.

---

## 🎯 Goals of the Project
- Identify patterns and anomalies related to heart attack risk  
- Build intuitive visualizations for clinicians, researchers, and policymakers  
- Analyze lifestyle risk factors (smoking, obesity, diabetes, alcohol, etc.)  
- Explore clinical indicators (cholesterol, heart rate, BMI, triglycerides)  
- Map demographic and geographic distributions  
- Build an interactive dashboard with dynamic filtering  
- Document steps for reproducibility and future research

---

## 🧠 Major Research Objectives
- ✔️ Perform data cleaning and exploratory data analysis  
- ✔️ Visualize lifestyle and metabolic risk factors  
- ✔️ Compare clinical measurements using scatterplots and heatmaps  
- ✔️ Analyze geographic and demographic risk distribution  
- ✔️ Build an interactive multi-factor dashboard  
- ✔️ Produce full documentation with reproducible R code

---

## 📊 Dataset Description
The dataset includes **8,763 patient records** with no missing values. Variables include:

### **Demographics**
- Age  
- Sex  
- Country, Continent, Hemisphere  

### **Clinical Measurements**
- Cholesterol  
- Blood Pressure  
- Heart Rate  
- BMI  
- Triglycerides  

### **Lifestyle & Health Behaviors**
- Smoking  
- Alcohol Consumption  
- Hours of Exercise  
- Hours of Sedentary Activity  
- Hours of Sleep  
- Obesity  
- Diabetes  
- Family History  

### **Target Variable**
**Heart Attack Risk (0 = No Risk, 1 = High Risk)**

---

## 📈 Visualizations Included

### **1️⃣ Lifestyle Risk Factors**
Bar charts comparing smoking, alcohol use, and physical activity to risk levels.  
Useful for exploring behavioral impacts on cardiovascular health.

### **2️⃣ Obesity & Diabetes Visualization**
Shows strong correlation between higher BMI categories and diabetes presence.  
Highlights metabolic contributors to heart attack risk.

### **3️⃣ Combined Risk Factors (Smoking × Obesity × Diabetes)**
Faceted charts showing which conditions are most associated with elevated risk.

### **4️⃣ Cholesterol vs. Heart Rate Scatterplot**
Explores the relationship between two continuous clinical variables.  
No strong linear trend detected.

### **5️⃣ 2D Density Heatmap**
Heatmap of cholesterol vs. heart rate, revealing density clusters.

### **6️⃣ Geographic Heatmap**
Visualizes age distributions across continents.  
Areas with older populations indicate higher general cardiovascular risk.

### **7️⃣ Interactive Dashboard**
Filters:
- Age Group  
- Continent  

All visualizations update dynamically for exploratory analysis.

---

## 🎨 Design Approach

### **Color Strategy**
- Sequential gradients for heatmaps  
- Neutral balanced colors for lifestyle & clinical charts  
- Consistent palette across all visuals for clarity

### **Scales**
- Linear scales for continuous variables  
- Categorical scales for behavioral and binary variables  
- Binned age ranges for simplified demographic visualizations

### **Dashboard Layout**
1. Demographics (age, geography)  
2. Lifestyle factors  
3. Clinical indicators  
4. Integrated dashboard  

This provides a natural narrative flow from general population characteristics to specific risk indicators.

---

## ✅ Key Findings

- Lifestyle factors (smoking, obesity, diabetes) showed weaker individual associations than expected.  
- Clinical indicators (cholesterol, heart rate) displayed clearer group distinctions.  
- **Age** remains the strongest and most consistent predictor across all regions.  
- Geographic differences suggest environmental and socioeconomic influences on risk.

---

## ⚠️ Limitations
- Missing clinical history variables (medications, hospitalizations, time-series data)  
- Some categorical variables (e.g., blood pressure) limit detailed analysis  
- Interactions among variables may not be captured in single-factor visualizations  
- Geographic data lacks contextual public health information

---

## 🚀 Future Enhancements

- Add machine learning models (logistic regression, random forest, SHAP analysis)  
- Explore variable interactions using multi-dimensional visualizations  
- Implement clustering to identify natural patient groups  
- Build a predictive dashboard with sliders for input variables  
- Add more clinical biomarkers (ECG data, inflammation markers)  
- Expand geographic analysis using environmental and healthcare system data

---

## 🛠️ R Code Used
The full report includes reproducible R code for:
- Bar charts (smoking, obesity, diabetes)  
- Scatterplots  
- Density heatmaps  
- Geographic heatmaps  
- Tile maps for multi-factor risk analysis  

(See `report/Data viz final report.pdf` for complete code.)

---

## 📦 Recommended Project Structure
