#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

echo ""
echo -e "${RED}Shiny Server version:${NC}"
shiny-server --version

echo ""
echo -e "${RED}R version:${NC}"
R --version

echo ""
echo -e "${RED}R packages versions:${NC}"
R -q --no-save -e 'ip <- as.data.frame(installed.packages()[,c(1,3:4)]); rownames(ip) <- NULL; ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]; print(ip, row.names=FALSE)'

