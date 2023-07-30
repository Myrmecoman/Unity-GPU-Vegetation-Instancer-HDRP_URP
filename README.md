# HDRP-Vegetation-Instancer

![Presentation](./presentation.png?raw=true "Presentation")

## Overview

HDRP vegetation instancer is a unity project whose goal is to bring vegetation details into unity terrains. All objects are proceduraly placed on the terrain without requiring any data saving. This makes the project very lightweight. Assets (like ferns) come from the Unity HDRP Terrain tools.

It consists in 2 main scripts :

- GrassInstancer.cs : in charge of displaying large amounts of grass (up to millions) using a custom shader and GPU indirect rendering. The shader comes from this repository (with slight changes) : https://github.com/MangoButtermilch/Unity-Grass-Instancer. Also thanks to Acerola for the code explanation here : https://github.com/GarrettGunnell/Grass.

![GrassInstancer](./grassInstancer.png?raw=true "GrassInstancer")

- VegetationInstancer.cs : in charge of displaying lower amounts of larger vegetation objects (ferns, bushes, etc...). This one works with any shader as long as GPU instancing is enabled, but is less optimized and can therefore work with fewer instances (about 10000).

![VegetationInstancer](./vegetationInstancer.png?raw=true "VegetationInstancer")

Note that this project only spawns vegetation objects without colliders at the moment.

## How to use

Put the GrassInstancer.cs and VegetationInstancer.cs on an empty GameObject and fill in the parameters.   
See below for the usage of VegetationInstancer.cs, GrassInstancer.cs is similar in it's parameters.

![Usage](./usage.png?raw=true "Usage")

## Code explanation

GrassInstancer and VegetationInstancer both use the same code to generate the objects positions at runtime using burst.   
The positions are not constantly regenerated, but only if a new chunk enters the camera frustrum. Finding new chunks is done in PickVisibleChunkJob.cs. Due to this, no CPU computation is required when the camera does not move. When a new chunk enters the camera view, all positions inside it are generated in a dedicated burst job (PositionsJob.cs).   
TerrainHeight.cs and TerrainsTextures.cs are used to sample the terrain in efficiently using Native unmanaged containers.

All the code is commented and was made to be easily readable.

## Work in progress

Better randomization, currently patterns can be recognized.
Support multiple objects instantiation for VegetationInstancer.cs.   
Be able to place objects with a density lower than 1 object per meter.
Distance culling for grass (this way chunks are no longer visible).
