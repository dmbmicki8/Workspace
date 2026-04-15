# **Geospatial**  


## **The John Snow Cholera Map (1854)**


<img src="../images/drjohnsnow.jpg" style="width:300px" />

One of the first real-world uses of geospatial analysis was in 1854 when **Dr. John Snow** mapped cholera deaths in London. His analysis helped identify the **Broad Street water pump** as the source of the epidemic, leading to the pump’s shutdown and saving lives.  

<img src="../images/map.bmp" style="width:300px" />


- **Location analysis reveals hidden patterns.**  
- **Geospatial data has been crucial in public health, urban planning, and crime analysis.**  


# **Real-World Applications of Geospatial Data**
### **Use Cases**
| Industry | Application |
|-----------|------------|
| **Marketing & Sales** | Customer segmentation, site selection, targeted ads |
| **Transportation & Logistics** | Route optimization, delivery efficiency |
| **Sociology** | Crime tracking, urban planning |
| **Epidemiology** | Disease outbreak tracking, risk assessment |
| **Environmental Science** | Climate change monitoring, weather pattern analysis |



# **Geospatial Analysis in Python**
## **Setting Up Your Environment**
To begin working with geospatial data, you'll need Python libraries like **GeoPandas, Folium, and Shapely**.

**Install and activate the environment:**  
```bash
# Install libraries (if not installed)
pip install geopandas folium shapely

# Activate geospatial environment
conda activate geospatial

# Start Jupyter Notebook
jupyter notebook
```


# **Introduction to GeoDataFrames**
## **What is a GeoDataFrame?**
A **GeoDataFrame** is a Pandas DataFrame with an additional **geometry column** that stores spatial data (points, lines, polygons). It allows easy manipulation of geospatial data.

```python
import geopandas as gpd

# Read a geospatial file (e.g., GeoJSON, Shapefile)
gdf = gpd.read_file("neighborhoods.geojson")

# Check the first few rows
print(gdf.head())
```

### **Differences Between Pandas and GeoPandas**
| Feature | Pandas DataFrame | GeoPandas GeoDataFrame |
|---------|----------------|------------------------|
| **Data Type** | Tabular (CSV, SQL) | Geospatial (GeoJSON, Shapefile) |
| **Spatial Data** | No support | Supports points, lines, polygons |
| **Spatial Operations** | Not available | Supports geospatial joins, projections, etc. |

### **Key GeoDataFrame Attributes**
| Attribute | Description |
|-----------|------------|
| `.geometry` | The spatial column containing points, lines, or polygons |
| `.crs` | The Coordinate Reference System (CRS) used for mapping |
| `.area` | Computes the area of polygons |
| `.centroid` | Finds the center of a geometry |
| `.distance()` | Measures the distance between geometries |


# **Geospatial Geometries**
## **Types of Geospatial Objects**
| Geometry Type | Example Use Case |
|--------------|----------------|
| **Point** | Locations of bus stops, store locations |
| **Line** | Roads, rivers, transit routes |
| **Polygon** | Neighborhoods, city boundaries, building footprints |

<img src="../images/geo_pnt_line_poly.png" style="width:300px" />


Example:
```python
from shapely.geometry import Point, LineString, Polygon

# Create geospatial objects
point = Point(12.5, 41.9)  # A single location
line = LineString([(0, 0), (1, 2), (2, 3)])  # A path
polygon = Polygon([(0, 0), (1, 1), (1, 0)])  # An enclosed area
```


# **Understanding Coordinate Reference Systems (CRS)**
## **What is a CRS?**
A **Coordinate Reference System (CRS)** defines how geographic coordinates (latitude, longitude) map to real-world locations. Different projections exist to account for the Earth's curvature.

```python
# Check CRS of a GeoDataFrame
print(gdf.crs)
```
- If two datasets use different CRS, you must reproject one to match the other.



# **Spatial Joins in GeoPandas**
Spatial joins allow us to **merge** two datasets based on **spatial relationships** instead of common columns.

## **Common Spatial Joins**
| Predicate | Description |
|-----------|------------|
| `contains` | Find polygons that contain points |
| `intersects` | Find geometries that touch each other |
| `within` | Find points that fall within polygons |

### **Performing a Spatial Join**
Example: Assigning bus stops to neighborhoods
```python
# Load data
neighborhoods = gpd.read_file("neighborhoods.geojson")
bus_stops = gpd.read_file("bus_stops.geojson")

# Spatial join: Find which neighborhood each bus stop is in
bus_stops_in_neighborhoods = gpd.sjoin(bus_stops, neighborhoods, predicate='within')

# Display results
print(bus_stops_in_neighborhoods.head())
```

- The left dataset (`bus_stops`) retains its geometry, while matching attributes from the right dataset (`neighborhoods`) are added.



# **Creating Interactive Maps with Folium**
## **What is Folium?**
Folium is a powerful Python library for creating **interactive maps** using Leaflet.js. This will create a visualization called a [Choropleth](https://medium.com/analytics-vidhya/create-and-visualize-choropleth-map-with-folium-269d3fd12fa0)

## **Creating a Simple Map**
```python
import folium

# Create a basic map centered at a location
m = folium.Map(location=[36.1627, -86.7816], zoom_start=12)

# Add a marker
folium.Marker([36.1627, -86.7816], popup="Nashville").add_to(m)

# Display map
m
```

# **Hands-On with Geospatial Data**
### **Instructions**
1. Visit [Nashville Open Data](https://data.nashville.gov/) and search for **GIS** datasets.  
2. Download a dataset containing spatial data (e.g., crime reports, bus stops, parks).  
3. Load the dataset into a Jupyter Notebook using **GeoPandas**.  
4. Perform **spatial joins** with another dataset (e.g., crime locations within neighborhoods).  
5. Visualize your results using **Folium** maps.  


# **Additional Resources**
- 📖 **GeoPandas Documentation**: [https://geopandas.org/en/stable/](https://geopandas.org/en/stable/)  
- 🌎 **Understanding CRS & Projections**: [https://earthdatascience.org](https://www.earthdatascience.org/courses/earth-analytics/spatial-data-r/intro-to-coordinate-reference-systems/)  
- 🗺️ **Folium Documentation**: [https://python-visualization.github.io/folium/modules.html](https://python-visualization.github.io/folium/modules.html)  
- 💡 **GIS StackExchange**: [https://gis.stackexchange.com/](https://gis.stackexchange.com/)  


# **TL;DR**
- **Geospatial analysis helps uncover location-based insights** (e.g., John Snow’s cholera map).  
- **GeoPandas extends Pandas for spatial data** (with points, lines, and polygons).  
- **CRS ensures correct mapping of coordinates** (e.g., WGS 84 is widely used).  
- **Spatial joins allow datasets to be merged based on geography** (e.g., find bus stops within neighborhoods).  
- **Folium creates interactive, shareable maps** for better data storytelling.  
