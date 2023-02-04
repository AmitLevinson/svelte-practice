library(readxl)
library(dplyr)
dat <- read_xlsx('mks_presence.2023-01-01.2023-01-31.xlsx',skip = 7)
dat %>% 
  clipr::write_clip()
