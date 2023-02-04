
# scrape images -----------------------------------------------------------

library(dplyr)
library(purrr)
library(rvest)
library(magick)
library(magrittr)


# Images locations --------------------------------------------------------
attendance <- read_html('https://www.zmanknesset.co.il/mks_presence')

raw_image_data <- attendance %>%
  html_nodes('table tbody td.photo img')  
  

parsed_image_data <- data.frame(
    mk_name = html_attr(raw_image_data, 'title'),
    image_url = html_attr(raw_image_data, 'src')
)

# Read and save images ----------------------------------------------------
parsed_image_data %$%
  walk2(mk_name, image_url, function (mk_name, image_url) {
    Sys.sleep(1)
    print(mk_name)
    image_read(image_url) %>% 
    image_write(paste0('mks/', mk_name, '.png'))
  })


