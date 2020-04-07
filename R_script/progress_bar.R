library(progress)

pb <- progress_bar$new(total = 1000)

  
  pb <- progress_bar$new(
    format = "  downloading [:bar] :percent eta: :eta",
    total = 1000, clear = FALSE, width= 60)
  for (i in 1:1000) {
    pb$tick()
    Sys.sleep(1 / 100)
  }


for (i in 1:1000) {
  pb$tick()
  Sys.sleep(1 / 100)
}