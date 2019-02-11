# ARGalaxy-docker
Builds a Galaxy Docker with the ARGalaxy pipelines:  
[SHM & CSR Pipeline](https://toolshed.g2.bx.psu.edu/view/davidvanzessen/shm_csr/7b9481fa4a70) ([Github](https://github.com/ErasmusMC-Bioinformatics/shm_csr))  
[Immune Repertoire Pipeline](https://toolshed.g2.bx.psu.edu/view/davidvanzessen/argalaxy_tools/4d2a8f98a502) ([Github](https://github.com/ErasmusMC-Bioinformatics/Argalaxy-ImmuneRepertoire))

## Start

### Building
Build with:  
`docker build -t argalaxy .`  
Start with:  
`docker run -p 8080:80 argalaxy:latest`  
Then open `localhost:8080` in a browser. 

### Quay.io

Pull with:  
`docker pull quay.io/erasmusmc_bioinformatics/argalaxy`

Start with:  
`docker run -p 8080:80 quay.io/erasmusmc_bioinformatics/argalaxy`

Visit localhost:8080 in a webbrowser to start using ARGalaxy.

## Data Persistence
If you don't want to lose your data when restarting the Docker image, add the `-v` flag to create a local mountpoint:  
`docker run -p 8080:80 -v /path/to/local/dir/:/export/ argalaxy:latest`  
