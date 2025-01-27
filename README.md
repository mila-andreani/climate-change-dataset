

# Climate Change Projections Dataset

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by/4.0/)

 

<img align="left" src="img.jpeg" width="240" height="240"> Climate change is shaping a  world different from the one that we are used to. The urgent need to adapt to this new reality and mitigate climate-related risks led to the implementation of numerous climate policies fostering the transition to a low-carbon economy. 


_...But what will happen if the climate targets won't be met? How will future socio-economic adaptations reshape the reality that we currently live in?_



This dataset has been created to help researchers to make a little step towards answering these questions :crystal_ball: as part of my PhD thesis, in which a novel machine learning algorithm developed in the same dissertation [^1] has been used to assess the effects of the distruptive changes induced by climate shocks on the future economic system.

[^1]: Andreani, Mila, Lea Petrella, and Nicola Salvati. "New advances in Regression Forests." Statistical Learning, Sustainability and Impact Evaluation. Pearson, 2023. 1297-1302.

In particular, the dataset amalgamates historical climate data with forward-looking projections derived from the Coupled Model Intercomparison Project Phase 6 (CMIP6) simulations [^2] in a longitudinal shape. Spanning the period from 1995 to 2100 and encompassing 210 countries, the dataset offers the possibility to researcher to assess the presence of climate-economic interactions. For each country-year observation, key climate variables such as temperature, precipitation, and extreme weather indices are included, alongside GDP per capita data sourced from the World Bank. 

[^2]: GDP projected data: https://tntcat.iiasa.ac.at/SspDb/dsd?Action=htmlpage&page=citation, 
GDP historical data: https://data.worldbank.org/, 
Climate-related variables historical and projected data: https://climateknowledgeportal.worldbank.org

# Ready to use Datasets

The datasets are ready to be used and can be downloaded in R:
 
``` r
library(readr)
hist <- read_csv("https://raw.githubusercontent.com/mila-andreani/climate-change-dataset/main/hist/hist.csv")
SSP1 <- read_csv("https://raw.githubusercontent.com/mila-andreani/climate-change-dataset/main/projections/SSP1/projSSP1.csv")
SSP2 <- read_csv("https://raw.githubusercontent.com/mila-andreani/climate-change-dataset/main/projections/SSP2/projSSP2.csv")
SSP3 <- read_csv("https://raw.githubusercontent.com/mila-andreani/climate-change-dataset/main/projections/SSP3/projSSP3.csv")
SSP5 <- read_csv("https://raw.githubusercontent.com/mila-andreani/climate-change-dataset/main/projections/SSP5/projSSP5.csv")
```

and Python

```bash
import pandas as pd

hist = pd.read_csv(r"https://raw.githubusercontent.com/mila-andreani/climate-change-dataset/main/hist/hist.csv")
SSP1 = pd.read_csv(r"https://raw.githubusercontent.com/mila-andreani/climate-change-dataset/main/projections/SSP1/projSSP1.csv")
SSP2 = pd.read_csv(r"https://raw.githubusercontent.com/mila-andreani/climate-change-dataset/main/projections/SSP2/projSSP2.csv")
SSP3 = pd.read_csv(r"https://raw.githubusercontent.com/mila-andreani/climate-change-dataset/main/projections/SSP3/projSSP3.csv")
SSP5 = pd.read_csv(r"https://raw.githubusercontent.com/mila-andreani/climate-change-dataset/main/projections/SSP5/projSSP5.csv")
```

# Dataset Description and Code

The dataset contains annual longitudinal data concerning climate-related variables and GDP. 

Up to now the projects is structured as follows:

- [`R/`](R): contains the scripts to re-create the the longitudinal datasets (also the stationarized version) using R starting from raw data, contained in the .zip files 'raw_data' to be unzipped before running the code.
- [`hist/`](hist): contains historical data from 1995 to 2014 of 210 countries.
- [`projections/`](projections): contains annual projected data of the climate-related variables as formulated in CMIP6 from 2015 to 2100 under four different scenarios: SSP1, SSP2, SSP3, SSP5. For each SSP there are also .zip files ('raw_data') with the original data for each country in the sample. The folder contain also the file _'proj_gdp.xlsx'_, with additional projections for each SSP of GDP every 5 years up to 2100.
- [`countries_info.xlsx`](countries_info.xlsx): contains info on the ISO-3 country codes and ids used in the dataset. 

## Variables

| Variable Name  | Description |
| ------------- | ------------- |
| **GDP**  | Gross Domestic Product per capita |
| **TMP**  | Average annual temperature  |
| **PRE**  | Average annual precipitations  |
|  **r20mm** | Precipitations >20mm  |
|  **cwd** | Maximum number of consecutive wet days  |
|  **cdd** | Maximum number of consecutive dry days  |
|  **txx** | Maximum daily temperature  |

## CMIP6 and Climate Projections

The Coupled Model Intercomparison Project Phase 6 (CMIP6) serves as a cornerstone in climate science, facilitating the comparison of climate models across various institutions and research groups worldwide. CMIP6 encompasses a vast ensemble of state-of-the-art climate models, each simulating Earth's climate system under different scenarios and assumptions.

Climate projections derived from CMIP6 simulations offer invaluable insights into potential future climate scenarios, encompassing a range of variables such as temperature, precipitation, and extreme weather events. These projections serve as crucial inputs for understanding the complex interplay between climate dynamics and socio-economic outcomes.

## Understanding the Shared Socio-economic Pathways (SSPs)

The Shared Socio-economic Pathways (SSPs) represent a set of narratives outlining plausible future socio-economic trajectories and corresponding climate scenarios. Developed by the scientific community, SSPs provide a framework for exploring how different societal choices and policy decisions could shape the future of humanity and the environment. Let's delve deeper into the key components and implications of SSPs:

### Origins and Development

The SSP framework emerged from the need for a standardized approach to integrate socio-economic factors into climate change research. Developed as part of the Fifth Assessment Report (AR5) of the Intergovernmental Panel on Climate Change (IPCC), SSPs build upon earlier scenarios such as the Special Report on Emissions Scenarios (SRES).

### Components of SSPs

SSPs are characterized by five distinct narratives, each depicting a unique vision of the future:

**SSP1: Sustainability**

SSP1 portrays a world where sustainability and environmental stewardship are paramount. It envisions rapid technological progress, low population growth, and a shift towards renewable energy sources. This pathway prioritizes sustainable development goals and emphasizes global cooperation to address climate change.

**SSP2: Middle of the Road**

SSP2 represents a future where current trends continue without significant deviation. It envisions moderate population growth, gradual technological advancements, and a mix of fossil fuels and renewable energy sources. This pathway reflects a world where socio-economic development follows historical patterns without major disruptions.

**SSP3: Regional Rivalry**

SSP3 depicts a world characterized by fragmented regional interests and limited global cooperation. It envisions high population growth, slow technological progress, and a reliance on fossil fuels. This pathway reflects a future marked by geopolitical tensions, resource competition, and uneven development.

**SSP4: Inequality**

SSP4 portrays a future defined by stark socio-economic disparities and limited environmental regulations. It envisions moderate population growth, slow technological progress, and a reliance on fossil fuels. This pathway highlights the challenges of addressing climate change in a world marked by inequality and social unrest.

**SSP5: Fossil-Fueled Development**

SSP5 represents a future where economic growth is prioritized over environmental concerns. It envisions high population growth, rapid technological progress focused on fossil fuel extraction, and limited efforts to mitigate climate change. This pathway underscores the risks of continued reliance on fossil fuels and the need for transformative change.

## Citation

If you plan to use this dataset or other resources you'll find in this page, please cite this repository:

	@misc{Andreani_A_Longitudinal_dataset_2024,
 		author = {Andreani, Mila and Petrella, Lea and Salvati, Nicola},
		doi = {10.5281/zenodo.1234},
		month = may,
		title = {{A Longitudinal dataset on climate projections and economic variables}},
		url = {https://github.com/mila-cc/climate-change-dataset},
		year = {2024}
		}
 ## License

This work is licensed under a <a href="https://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>. 

----------------------------------------------

## Author

* Mila Andreani - email: *mila.andreani@sns.it*
