### 1. Getting Started With the Geospatial Environment
To run the notebooks for this project, you will need some additional python packages. 
You can install these using conda. 
We have provided an `environment.yaml` file with the packages to be used for the project.
This `environment.yaml` file will create a new environment for you called `geospatial`.

Open your terminal, and `cd` into this project. 
From there run: 
```bash
conda env create -f environment.yaml
```

Once this has been created for you, it is easiest to run from the command line.
For example, to open a new session with jupyter run: 
```
conda activate geospatial
jupyter notebook
```
To close the notebook, type ctrl-c
To stop using the geospatial environment:
```
conda deactivate
```


### 2. Introduction slide deck and notebooks  
##### slides 
 - importance of location to some kinds of analysis
 - `geopandas` GeoDataFrames
 - types of geometry
 - intro to coordinate reference systems
 - spatial joins
 - adding context with `folium` maps
    - constructing maps
    - markers
    - marker clusters
    - popups
##### notebooks
- geospatial_intro.ipynb (geopandas and foilum)
- qualitative_maps.ipynb (geopandas and matplotlib styling elements)
- choropleth_tutorial.ipynb (geopandas choropleth)
