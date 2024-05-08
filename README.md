# Climate Change Projections Dataset

This dataset has been used in my PhD thesis to assess the effects of climate change on the economic system by leveraging the novel machine learning algorithm developed in the sme thesis to forecast economic resilience and inform policy decisions in an era of environmental uncertainty. 

The dataset amalgamates historical climate data with forward-looking projections derived from CMIP6 simulations. Spanning the period from 1995 to 2100 and encompassing 210 countries, the dataset offers a comprehensive view of climate-economic interactions. For each country-year observation, key climate variables such as temperature, precipitation, and extreme weather indices are included, alongside GDP per capita data sourced from the World Bank. Additionally, the dataset incorporates covariates representing historical values of projected climate variables, enabling researchers to explore the nuanced relationships between climate dynamics and economic outcomes.

# Climate Change

Climate change stands as one of the defining challenges of the 21st century, with its far-reaching impacts permeating every facet of human existence. From altering weather patterns to exacerbating natural disasters, the consequences of a warming planet reverberate across ecosystems, economies, and societies worldwide.

Central to the discourse on climate change is its profound effect on economic systems. The intricate interplay between climate dynamics and economic outcomes is a topic of growing concern and academic inquiry. As the frequency and intensity of extreme weather events escalate, economies are confronted with mounting challenges, ranging from infrastructural damage to disruptions in agricultural production and supply chains.

# Dataset description and Code

The dataset contains annual longitudinal data concerning climate-related variables and GDP. The folder **_'hist_** contains historical data from 1995 to 2014 of 210 countries, wherear the folder **_'proj_** contains annual projected data of the climate-related variables as formulated in the Coupled Model Intercomparison Project Phase 6 (CMIP6) from 2015 to 2100 under four different scenarios: SSP1, SSP2, SSP3, SSP5.

The dataset contains also the stationarised version of the historical and projected dataframes.

Two additional files are present: the _'countries_info.xlsx'_ file contains info on the ISO-3 country codes and ids used in the dataset. The _'proj_gdp.xlsx'_ contains additional projections of GDP every 5 years up to 2100.

The code contained in the folder **_'Code'_** allows to re-create the the longitudinal datasets (also the stationarized version) starting from raw data, contained in the 'raw_data' to be unzipped before running the code.

The following paragraphs contain additional info on the dataset and the research question.

##Variables



## CMIP6 and Climate Projections

The Coupled Model Intercomparison Project Phase 6 (CMIP6) serves as a cornerstone in climate science, facilitating the comparison of climate models across various institutions and research groups worldwide. CMIP6 encompasses a vast ensemble of state-of-the-art climate models, each simulating Earth's climate system under different scenarios and assumptions.

Climate projections derived from CMIP6 simulations offer invaluable insights into potential future climate scenarios, encompassing a range of variables such as temperature, precipitation, and extreme weather events. These projections serve as crucial inputs for understanding the complex interplay between climate dynamics and socio-economic outcomes.

## Climate Effects on GDP
The impacts of climate change on economic output are multifaceted and far-reaching, encompassing both direct and indirect channels. Direct effects manifest through the increased frequency and intensity of extreme weather events, leading to infrastructural damage, disruptions in agricultural production, and heightened economic volatility (physical risks). Indirect effects permeate through shifts in migration patterns, demographic changes, and alterations in productivity and labor supply, ultimately shaping the resilience and adaptability of economies worldwide (transition risks).


